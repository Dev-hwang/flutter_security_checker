package com.pravera.flutter_security_checker

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** FlutterSecurityCheckerPlugin */
class FlutterSecurityCheckerPlugin : FlutterPlugin {
  private lateinit var methodCallHandler: MethodCallHandlerImpl

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    methodCallHandler = MethodCallHandlerImpl(binding.applicationContext)
    methodCallHandler.init(binding.binaryMessenger)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    if (::methodCallHandler.isInitialized) {
      methodCallHandler.dispose()
    }
  }
}
