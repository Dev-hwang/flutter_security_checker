package com.pravera.flutter_security_checker.security

import android.content.Context
import android.os.Build

class IntegrityChecker {
	companion object {
		fun hasCorrectlyInstalled(context: Context?): Boolean {
			if (context == null) return false

			val packageName: String? = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
				context.packageManager.getInstallSourceInfo(context.packageName).installingPackageName
			else
				context.packageManager.getInstallerPackageName(context.packageName)
			if (packageName == null) return false

			return packageName == "com.android.vending"
					|| packageName == "com.google.android.packageinstaller"
					|| packageName == "com.skt.skaf.A000Z00040"
					|| packageName == "com.kt.olleh.storefront"
					|| packageName == "android.lgt.appstore"
					|| packageName == "com.lguplus.appstore"
					|| packageName == "com.sec.android.app.samsungapps"
					|| packageName == "com.samsung.android.mateagent"
					|| packageName == "com.sec.android.easyMover.Agent"
		}
	}
}
