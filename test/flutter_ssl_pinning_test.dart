import 'package:flutter_ssl_pinning/flutter_ssl_pinning_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSslPinningPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSslPinningPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  // final FlutterSslPinningPlatform initialPlatform = FlutterSslPinningPlatform.instance;
  //
  // test('$MethodChannelFlutterSslPinning is the default instance', () {
  //   expect(initialPlatform, isInstanceOf<MethodChannelFlutterSslPinning>());
  // });
  //
  // test('getPlatformVersion', () async {
  //   FlutterSslPinning flutterSslPinningPlugin = FlutterSslPinning();
  //   MockFlutterSslPinningPlatform fakePlatform = MockFlutterSslPinningPlatform();
  //   FlutterSslPinningPlatform.instance = fakePlatform;
  //
  //   expect(await flutterSslPinningPlugin.getPlatformVersion(), '42');
  // });
}
