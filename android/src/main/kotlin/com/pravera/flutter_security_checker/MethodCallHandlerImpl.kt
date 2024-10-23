package com.pravera.flutter_security_checker

import android.content.Context
import com.pravera.flutter_security_checker.security.DeviceChecker
import com.pravera.flutter_security_checker.security.IntegrityChecker
import com.scottyab.rootbeer.RootBeer

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** MethodCallHandlerImpl */
class MethodCallHandlerImpl(private val context: Context) : MethodChannel.MethodCallHandler {
	private lateinit var channel: MethodChannel

	fun init(messenger: BinaryMessenger) {
		channel = MethodChannel(messenger, "flutter_security_checker")
		channel.setMethodCallHandler(this)
	}

	fun dispose() {
		if (::channel.isInitialized) {
			channel.setMethodCallHandler(null)
		}
	}

	override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
		when (call.method) {
			"isRooted" -> result.success(RootBeer(context).isRooted)
			"isRealDevice" -> result.success(DeviceChecker.isRealDevice())
			"hasCorrectlyInstalled" -> result.success(IntegrityChecker.hasCorrectlyInstalled(context))
			else -> result.notImplemented()
		}
	}
}
