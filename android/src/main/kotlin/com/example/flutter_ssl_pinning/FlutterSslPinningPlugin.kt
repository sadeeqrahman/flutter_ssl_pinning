package com.example.flutter_ssl_pinning

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import okhttp3.*

class FlutterSslPinningPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var client: OkHttpClient? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "flutter_ssl_pinning")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        when (call.method) {

            "init" -> {
                val pins = call.argument<Map<String, List<String>>>("pins")

                val builder = CertificatePinner.Builder()

                pins?.forEach { (host, pinList) ->
                    pinList.forEach { pin ->

                        // IMPORTANT: must already include sha256/
                        builder.add(host, pin)
                    }
                }

                val pinner = builder.build()

                client = OkHttpClient.Builder()
                    .certificatePinner(pinner)
                    .build()

                result.success(true)
            }

            "request" -> {

                val url = call.argument<String>("url")!!

                val req = Request.Builder()
                    .url(url)
                    .build()

                try {
                    val response = client!!.newCall(req).execute()
                    result.success(response.body?.string())
                } catch (e: Exception) {
                    result.error(
                        "SSL_ERROR",
                        "SSL Handshake failed: ${e.message}",
                        null
                    )
                }
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}