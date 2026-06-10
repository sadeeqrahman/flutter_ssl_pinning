import 'package:flutter/material.dart';
import 'package:flutter_ssl_pinning/flutter_ssl_pinning.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔐 Initialize SSL pinning
  await SslPinning.initialize(
    pins: {
      "google.com": [
        // ⚠️ Replace with REAL SHA256 SPKI pin
        "sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=",
      ],
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "Not tested";

  Future<void> testApi() async {
    setState(() {
      result = "Testing...";
    });

    try {
      // ⚠️ This will ONLY be protected if your native layer is enforcing pinning
      final response = await Uri.parse("https://google.com").resolveUri(Uri());

      setState(() {
        result = "SUCCESS (200)";
      });
    } catch (e) {
      setState(() {
        result = "FAILED: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SSL Pinning Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(result),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: testApi, child: const Text("Test API")),
          ],
        ),
      ),
    );
  }
}
