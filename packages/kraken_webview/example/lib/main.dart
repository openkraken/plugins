import 'package:flutter/material.dart';
import 'package:kraken_webview/kraken_webview.dart';
import 'package:kraken/kraken.dart';

void main() {
  KrakenWebView.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
            Kraken(bundle: KrakenBundle.fromUrl('assets:///assets/bundle.js')),
      ),
    );
  }
}
