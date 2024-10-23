This plugin provides the ability to verify rooting and integrity on Android and iOS platforms.

[![pub package](https://img.shields.io/pub/v/flutter_security_checker.svg)](https://pub.dev/packages/flutter_security_checker)

## Features

* Can check whether the device is rooted or jailBroken.
* Can check whether the device on which the app is installed is a physical device.
* Can check that the app is installed through the correct content service (such as Google Play or Apple Store).

## Support version

- Flutter: `3.3.0+`
- Dart: `2.18.0+`
- Android: `5.0+ (minSdkVersion: 21)`
- iOS: `12.0+`

## Getting started

To use this plugin, add `flutter_security_checker` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/). For example:

```yaml
dependencies:
  flutter_security_checker: ^3.2.0
```

## How to use

```dart
import 'package:flutter_security_checker/flutter_security_checker.dart';

void _onCheckButtonPressed() async {
  // Check whether the device is rooted or jailBroken.
  // In Android Emulator or iOS Simulator it always returns true.
  final bool isRooted = await FlutterSecurityChecker.isRooted;
  
  // Check whether the device on which the app is installed is a physical device.
  final bool isRealDevice = await FlutterSecurityChecker.isRealDevice;
  
  // Check that the app is installed through the correct content service (such as Google Play or Apple Store).
  // It is not an app installed through content service or always returns false in debugging mode.
  final bool hasCorrectlyInstalled = await FlutterSecurityChecker.hasCorrectlyInstalled;
}
```

**NOTE:** The `isRooted` and `hasCorrectlyInstalled` functions may not work properly in the development environment. In development environment, it is recommended to turn off notifications using the `kReleaseMode` of the `flutter/foundation.dart` package appropriately.

## Support

If you find any bugs or issues while using the plugin, please register an issues on [GitHub](https://github.com/Dev-hwang/flutter_security_checker/issues). You can also contact us at <hwj930513@naver.com>.
