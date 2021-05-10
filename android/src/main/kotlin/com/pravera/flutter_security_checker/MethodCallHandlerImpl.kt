package com.pravera.flutter_security_checker

import android.app.Activity
import androidx.annotation.NonNull
import com.pravera.flutter_security_checker.errors.ErrorCodes
import com.pravera.flutter_security_checker.security.DeviceChecker
import com.pravera.flutter_security_checker.security.IntegrityChecker
import com.scottyab.rootbeer.RootBeer

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/** MethodCallHandlerImpl */
class MethodCallHandlerImpl: MethodChannel.MethodCallHandler {
	private lateinit var channel: MethodChannel
	
	private var activity: Activity? = null

	fun startListening(messenger: BinaryMessenger) {
		channel = MethodChannel(messenger, "flutter_security_checker")
		channel.setMethodCallHandler(this)
	}

	fun stopListening() {
		if (::channel.isInitialized)
			channel.setMethodCallHandler(null)
	}

	fun setActivity(activity: Activity?) {
		this.activity = activity
	}

	private fun handleError(result: MethodChannel.Result, errorCode: ErrorCodes) {
		result.error(errorCode.toString(), null, null)
	}

	override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
		if (activity == null) {
			handleError(result, ErrorCodes.ACTIVITY_NOT_REGISTERED)
			return
		}

		when (call.method) {
			"isRooted" -> {
				val rootBeer = RootBeer(activity)
				result.success(rootBeer.isRooted)
			}
			"isRealDevice" -> result.success(DeviceChecker.isRealDevice())
			"hasCorrectlyInstalled" -> result.success(IntegrityChecker.hasCorrectlyInstalled(activity))
			else -> result.notImplemented()
		}
	}
}
