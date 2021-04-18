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
bool isPirated = await getIsPirated();

print(isPirated);
// true - (iOS) if installed from AppStore or TestFlight, (Android) if installed from PlayStore
// false - if installed without authorization or receipt (Via ABD, APK, IPA)

//full example
bool isPirated = await getIsPirated(debugOverride: true, openStoreListing: true, appStoreId: '546532666', playStoreIdentifier: 'tikmoji.sethusenthil.com');
//debugOverride will disable installer integrity checking on debug mode (recommended setting after you finish setting up this lib!)
//openStoreListing will auto open your appstore or playstore listing depending on the platform

```

## Credits
Inspired and heavely based on https://github.com/caiopo/flutter-installer-info