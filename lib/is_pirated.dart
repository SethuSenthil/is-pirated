import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:url_launcher/url_launcher.dart';

const _channel = MethodChannel('com.sethusenthil.is_pirated');

/// Returns if the app is installed authentically.
///
/// On Android API 29 and below, uses Context.getInstallerPackageName()
/// On Android API 30 and above, uses PackageManager.getInstallSourceInfo()
/// On iOS, parses Bundle.main.appStoreReceiptURL
Future<IsPirated?> getIsPirated({
  bool? debugOverride,
  bool? openStoreListing,
  String? appStoreId,
  String? playStoreIdentifier,
}) async {
  final installerName = await _channel.invokeMethod('getIsPirated');

  bool isItPirated = false;
  //Return True if installed WITHOUT proper store autherositaion
  //Retuns False if installed through proper app store

  if (debugOverride == null) debugOverride = false;
  if (openStoreListing == null) openStoreListing = false;

  if (installerName == null &&
      (debugOverride ? Foundation.kReleaseMode : true)) {
    isItPirated = true;

    if (openStoreListing) {
      if (Platform.isIOS && appStoreId != null) {
        if (appStoreId.startsWith("id")) appStoreId = appStoreId.split("id")[1];
        launch('https://apps.apple.com/app/id' + appStoreId);
      }
      if (Platform.isAndroid && playStoreIdentifier != null)
        launch("https://play.google.com/store/apps/details?id=" +
            playStoreIdentifier);
    }
  }

  return IsPirated(isItPirated);
}

class IsPirated {
  /// The installer package name, as returned by the platform
  final bool isPirated;

  /// Bool value based on [installerName]

  IsPirated(this.isPirated);
}

/// Trusted installers
enum Installer {
  // Android
  googlePlay,

  // iOS
  appStore,
  testFlight,
  simulator,
}

// Installers whitelist
const _installerNames = {
  // Android
  'com.android.vending': Installer.googlePlay,

  // iOS
  'com.apple.AppStore': Installer.appStore,
  'com.apple.TestFlight': Installer.testFlight,
  'com.apple.CoreSimulator': Installer.simulator,
};
