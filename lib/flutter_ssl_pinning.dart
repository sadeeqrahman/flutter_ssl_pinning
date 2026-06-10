import 'package:flutter/services.dart';

class SslPinning {
  static const MethodChannel _channel = MethodChannel('flutter_ssl_pinning');

  static bool _initialized = false;

  /// Initialize SSL pinning
  static Future<void> initialize({
    required Map<String, List<String>> pins,
  }) async {
    try {
      await _channel.invokeMethod('init', {'pins': pins});
      _initialized = true;
    } catch (e) {
      throw Exception("SSL Pinning init failed: $e");
    }
  }

  /// Secure request via native layer
  static Future<String> request(String url) async {
    if (!_initialized) {
      throw Exception("SSL Pinning not initialized");
    }

    try {
      final result = await _channel.invokeMethod('request', {'url': url});

      return result.toString();
    } catch (e) {
      throw Exception("SSL request failed: $e");
    }
  }
}
