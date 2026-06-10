import 'package:flutter/services.dart';
import 'package:flutter_ssl_pinning/flutter_ssl_pinning_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('flutter_ssl_pinning');

  final platform = FlutterSslPinningMethodChannel();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall call) async {
      if (call.method == 'init') {
        return true;
      }
      if (call.method == 'request') {
        return 'SUCCESS_RESPONSE';
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('initialize SSL pinning', () async {
    await platform.initialize({
      "google.com": ["sha256/test"]
    });

    expect(true, isTrue);
  });

  test('request returns response', () async {
    final result = await platform.request("https://google.com");

    expect(result, 'SUCCESS_RESPONSE');
  });
}
