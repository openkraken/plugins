import 'package:flutter/material.dart';
import 'package:kraken/kraken.dart';
import 'dart:ui';

import 'package:kraken_camera/kraken_camera.dart';

void main() {
  KrakenCamera.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kraken Browser',
      // theme: ThemeData.dark(),
      home: MyBrowser(),
    );
  }
}

class MyBrowser extends StatefulWidget {
  MyBrowser({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyBrowser> {
  OutlineInputBorder outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    borderRadius: const BorderRadius.all(
      Radius.circular(20.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

    Kraken? kraken;
    final TextEditingController textEditingController = TextEditingController();

    kraken = Kraken(
        viewportWidth: window.physicalSize.width / window.devicePixelRatio,
        viewportHeight: window.physicalSize.height / window.devicePixelRatio -
            queryData.padding.top,
        bundle: KrakenBundle.fromUrl('assets:///assets/bundle.js'));

    return Scaffold(
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: kraken));
  }
}
