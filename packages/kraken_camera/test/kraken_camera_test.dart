import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kraken_camera/kraken_camera.dart';

void main() {
  const MethodChannel channel = MethodChannel('kraken_camera');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await KrakenCamera.platformVersion, '42');
  });
}
