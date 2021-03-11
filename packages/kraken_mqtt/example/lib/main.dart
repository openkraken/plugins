import 'package:flutter/material.dart';
import 'package:kraken_mqtt/kraken_mqtt.dart';
import 'package:kraken/kraken.dart';

void main() {
  KrakenMQTT.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Kraken(bundlePath: 'assets/bundle.js')
        ),
      ),
    );
  }
}
