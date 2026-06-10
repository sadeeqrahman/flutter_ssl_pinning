# flutter_ssl_pinning 🔐

A lightweight Flutter plugin that provides **SSL Pinning support for Android and iOS** using native implementations.

It helps protect your app from:
- Man-in-the-middle (MITM) attacks
- Fake certificates
- Network traffic interception

---

## 🚀 Features

- 🔐 SSL Certificate Pinning (Android - OkHttp)
- 🍏 SSL Pinning (iOS - URLSession + CryptoKit)
- 📱 MethodChannel-based communication
- 🌐 Host-based pin mapping
- ⚡ Lightweight and fast native validation

---

## 📦 Installation

Add dependency in your `pubspec.yaml`:

```yaml
dependencies:
  flutter_ssl_pinning: ^1.0.0