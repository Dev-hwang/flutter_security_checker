package com.pravera.flutter_security_checker.security

import android.os.Build

class DeviceChecker {
	companion object {
		fun isRealDevice(): Boolean {
			val isEmulator =
					(Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
					|| Build.FINGERPRINT.startsWith("generic")
					|| Build.FINGERPRINT.startsWith("unknown")
					|| Build.HARDWARE.contains("goldfish")
					|| Build.HARDWARE.contains("ranchu")
					|| Build.MODEL.contains("google_sdk")
					|| Build.MODEL.contains("Emulator")
					|| Build.MODEL.contains("Android SDK built for")
					|| Build.MODEL.startsWith("sdk_")
					|| Build.MANUFACTURER.contains("Genymotion")
					|| Build.PRODUCT.contains("sdk_google")
					|| Build.PRODUCT.contains("google_sdk")
					|| Build.PRODUCT.contains("sdk")
					|| Build.PRODUCT.contains("sdk_x86")
					|| Build.PRODUCT.contains("vbox86p")
					|| Build.PRODUCT.contains("emulator")
					|| Build.PRODUCT.contains("simulator")
					|| Build.DEVICE.startsWith("emulator")
					// another Android SDK emulator check
					|| SystemProperties.get("ro.kernel.qemu") == "1"
					|| Build.PRODUCT.toLowerCase().contains("nox")
					|| Build.BOARD.toLowerCase().contains("nox")
					|| Build.HARDWARE.toLowerCase().contains("nox")
					|| Build.MODEL.toLowerCase().contains("droid4x")
					|| Build.HARDWARE == "vbox86"
			return !isEmulator
		}
	}
}
