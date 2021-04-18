# is_pirated
Check if your app is installed from an unauthorised source

On Android API 29 and below, uses `Context.getInstallerPackageName()`

On Android API 30 and above, uses `PackageManager.getInstallSourceInfo()`

On iOS, parses `Bundle.main.appStoreReceiptURL`


Installing
----------

Add to your pubspec.yaml

```yaml
dependencies:
  is_pirated: <version>
```


Example
-------
```dart
IsPirated isPirated = await getIsPirated();

print(isPirated.status);
// true - (iOS) if installed from AppStore or TestFlight, (Android) if installed from PlayStore
// false - if installed without authorization or receipt (Via ABD, APK, IPA)

//full example
IsPirated isPirated = await getIsPirated(debugOverride: true, openStoreListing: true, appStoreId: '546532666', playStoreIdentifier: 'tikmoji.sethusenthil.com');
//debugOverride will disable installer integrity checking on debug mode (recommended setting after you finish setting up this lib!)
//openStoreListing will auto open your appstore or playstore listing depending on the platform

```

## Options for .getIsPirated()

| Name                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **debugOverride** | **bool** <br>Default set to false. Override unauthorised installation checking when on debug mode. Set this to true after configuring this library.                                                                                                                                                                                                                                                                                                                           |
| **openStoreListing** | **bool** <br>Default set to false. Open the AppStore or PlayStore listing if isPirated.status = true. Must set appStoreId & playStoreIdentifier for this to take any effect on its respective platform.                                                                                                                                                                                                                                                                                                                          |
| **appStoreId** | **String** <br>The AppStore App Id for your app so openStoreListing can open your store listing. You can find it in the url of your app: 'https://apps.apple.com/us/app/tikmoji/id**1546532666**' Must set openStoreListing true.                                                                                                                                                                                                                                                                                                                           |
| **playStoreIdentifier** | **String** <br>The PlayStore App Store Identifier for your app so it can open your listing on the PlayStore. You can find this in your manifest or your PlayStore URL: https://play.google.com/store/apps/details?id=**com.sethusenthil.tikmoji**                                                                                                                                                                                                                                                                                                                           |
| **closeApp** | **bool** <br>Default set to false. Closes and quits out of your app if isPirated.status = true. If openStoreListing is set to true, it will open your store listing before quitting. Note that getIsPirated() may not return a value if set to true because the Dart VM will likely be terminated before.                                                                                                                                                                                                                                                                                                                          |                                                                                                                                                                                                                                                                           |


## Credits
Inspired and heavely based on https://github.com/caiopo/flutter-installer-info