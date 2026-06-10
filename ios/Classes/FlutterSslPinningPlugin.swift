import Flutter
import UIKit
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
        result(FlutterError(code: "INIT_ERROR", message: "Invalid pins", details: nil))
      }

    case "request":
      result("iOS native request not implemented in this version")

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}