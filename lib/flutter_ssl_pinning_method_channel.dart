import 'package:flutter/services.dart';

class FlutterSslPinningMethodChannel {
  static const MethodChannel _channel = MethodChannel('flutter_ssl_pinning');

  /// Initialize SSL pins on native side
  Future<void> initialize(Map<String, List<String>> pins) async {
    await _channel.invokeMethod('init', {
      'pins': pins,
    });
  }

  /// Perform SSL pinned request via native layer
  Future<String> request(String url) async {
    final result = await _channel.invokeMethod(
      'request',
      {'url': url},
    );

    return result.toString();
  }
}
