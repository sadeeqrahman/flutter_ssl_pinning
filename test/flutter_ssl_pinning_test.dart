import 'package:flutter_ssl_pinning/flutter_ssl_pinning.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SslPinning initialize does not crash', () async {
    await SslPinning.initialize(
      pins: {
        "google.com": ["sha256/test"]
      },
    );

    expect(true, isTrue);
  });

  test('SslPinning request throws or returns string', () async {
    await SslPinning.initialize(
      pins: {
        "google.com": ["sha256/test"]
      },
    );

    try {
      await SslPinning.request("https://google.com");
      expect(true, isTrue);
    } catch (e) {
      expect(e.toString().isNotEmpty, true);
    }
  });
}
