import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_ssl_pinning_method_channel.dart';

abstract class FlutterSslPinningPlatform extends PlatformInterface {
  /// Constructs a FlutterSslPinningPlatform.
  FlutterSslPinningPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSslPinningPlatform _instance = MethodChannelFlutterSslPinning();

  /// The default instance of [FlutterSslPinningPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSslPinning].
  static FlutterSslPinningPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSslPinningPlatform] when
  /// they register themselves.
  static set instance(FlutterSslPinningPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
