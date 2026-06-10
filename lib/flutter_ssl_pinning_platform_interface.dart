import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class FlutterSslPinningPlatform extends PlatformInterface {
  FlutterSslPinningPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSslPinningPlatform _instance = _DummyFlutterSslPinning();

  static FlutterSslPinningPlatform get instance => _instance;

  static set instance(FlutterSslPinningPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> initialize(Map<String, List<String>> pins) {
    throw UnimplementedError('initialize() not implemented');
  }

  Future<String> request(String url) {
    throw UnimplementedError('request() not implemented');
  }
}

class _DummyFlutterSslPinning extends FlutterSslPinningPlatform {}
