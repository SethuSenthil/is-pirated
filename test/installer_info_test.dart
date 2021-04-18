import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_pirated/is_pirated.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.sethusenthil.is_pirated');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getIsPirated') {
        return 'com.android.vending';
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getIsPirated', () async {
    final installerInfo = await getIsPirated();
    expect(installerInfo!.installerName, 'com.android.vending');
    expect(installerInfo.installer, Installer.googlePlay);
  });
}
