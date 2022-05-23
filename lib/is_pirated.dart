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
  bool? closeApp,
  String? appStoreId,
  String? playStoreIdentifier,
}) async {
  final installerName = await _channel.invokeMethod('getIsPirated');

  bool isItPirated = false;
  //Return True if installed WITHOUT proper store autherositaion
  //Retuns False if installed through proper app store

  debugOverride ??= false;
  openStoreListing ??= false;
  closeApp ??= false;

// Installers whitelist
  const installers = [
    // Android
    'com.android.vending',

    // iOS
    'com.apple.AppStore',
    'com.apple.TestFlight',
    'com.apple.CoreSimulator',
  ];

  bool validInstaller = false;

  if (installerName != null) {
    installers.forEach((installer) {
      if (installerName == installer) {
        validInstaller = true;
      }
    });
  }

  if (!validInstaller && (debugOverride ? Foundation.kReleaseMode : true)) {
    isItPirated = true;

    if (openStoreListing) {
      if (Platform.isIOS && appStoreId != null) {
        if (appStoreId.startsWith("id")) appStoreId = appStoreId.split("id")[1];
        launchUrl(Uri.parse('https://apps.apple.com/app/id' + appStoreId),
            mode: LaunchMode.externalApplication);
      }
      if (Platform.isAndroid && playStoreIdentifier != null)
        launchUrl(
            Uri.parse("https://play.google.com/store/apps/details?id=" +
                playStoreIdentifier),
            mode: LaunchMode.externalApplication);
    }

    if (closeApp) exit(0);
  }

  return IsPirated(isItPirated);
}

class IsPirated {
  /// The installer package name, as returned by the platform
  final bool status;

  /// Bool value based on [installerName]

  IsPirated(this.status);
}
