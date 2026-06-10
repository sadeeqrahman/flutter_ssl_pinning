import Flutter
import UIKit
import Foundation
import CryptoKit

public class FlutterSslPinningPlugin: NSObject, FlutterPlugin {

  var pins: [String: [String]] = [:]

  public static func register(with registrar: FlutterPluginRegistrar) {

    let channel = FlutterMethodChannel(
        name: "flutter_ssl_pinning",
        binaryMessenger: registrar.messenger()
    )

    let instance = FlutterSslPinningPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    switch call.method {

    case "init":
      if let args = call.arguments as? [String: Any],
         let pinData = args["pins"] as? [String: [String]] {
        self.pins = pinData
        result(true)
      } else {
        result(false)
      }

    case "request":

      guard let args = call.arguments as? [String: Any],
            let urlString = args["url"] as? String,
            let url = URL(string: urlString) else {
        result(FlutterError(code: "INVALID_URL", message: "Invalid URL", details: nil))
        return
      }

      let session = URLSession(
          configuration: .default,
          delegate: self,
          delegateQueue: nil
      )

      let task = session.dataTask(with: url) { data, response, error in

        if let error = error {
          result(FlutterError(
              code: "SSL_ERROR",
              message: error.localizedDescription,
              details: nil
          ))
          return
        }

        let responseString = String(data: data ?? Data(), encoding: .utf8) ?? ""
        result(responseString)
      }

      task.resume()

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

// MARK: - SSL PINNING
extension FlutterSslPinningPlugin: URLSessionDelegate {

  public func urlSession(
      _ session: URLSession,
      didReceive challenge: URLAuthenticationChallenge,
      completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
  ) {

    guard let serverTrust = challenge.protectionSpace.serverTrust,
          let cert = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
      completionHandler(.cancelAuthenticationChallenge, nil)
      return
    }

    let host = challenge.protectionSpace.host.lowercased()
    let hash = sha256PublicKey(cert: cert)

    guard let validPins = pins[host],
          validPins.contains(hash) else {

      completionHandler(.cancelAuthenticationChallenge, nil)
      return
    }

    completionHandler(.useCredential, URLCredential(trust: serverTrust))
  }

  private func sha256PublicKey(cert: SecCertificate) -> String {

    guard let key = SecCertificateCopyKey(cert),
          let keyData = SecKeyCopyExternalRepresentation(key, nil) as Data? else {
      return ""
    }

    let hash = SHA256.hash(data: keyData)

    return hash.map { String(format: "%02x", $0) }.joined()
  }
}