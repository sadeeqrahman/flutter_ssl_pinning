import 'package:flutter/material.dart';
import 'package:flutter_ssl_pinning/flutter_ssl_pinning.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SslPinning.initialize(
    pins: {
      "google.com": ["sha256/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="],
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
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
    setState(() => result = "Testing...");

    try {
      final response = await SslPinning.request("https://google.com");

      setState(() {
        result = "SUCCESS: $response";
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
