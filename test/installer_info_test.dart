import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_pirated/is_pirated.dart';

void main() {
  const MethodChannel channel = MethodChannel('com.sethusenthil.is_pirated');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getIsPirated') {
        return false;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getIsPirated', () async {
    final isPirated = await getIsPirated();
    expect(isPirated!.status is bool, true);
  });
}
