import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kraken_geolocation/kraken_geolocation.dart';

void main() {
  const MethodChannel channel = MethodChannel('kraken_geolocation');

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
    expect(await KrakenGeolocation.platformVersion, '42');
  });
}
