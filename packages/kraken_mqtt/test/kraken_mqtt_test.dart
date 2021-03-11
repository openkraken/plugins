import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kraken_mqtt/kraken_mqtt.dart';

void main() {
  const MethodChannel channel = MethodChannel('kraken_mqtt');

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
    expect(await KrakenMqtt.platformVersion, '42');
  });
}
