import 'package:flutter/services.dart';

class SslPinning {
  static const MethodChannel _channel = MethodChannel('flutter_ssl_pinning');

  static Future<void> initialize({
    required Map<String, List<String>> pins,
  }) async {
    await _channel.invokeMethod('init', {'pins': pins});
  }

  static Future<String> request(String url) async {
    final result = await _channel.invokeMethod('request', {'url': url});

    return result;
  }
}
