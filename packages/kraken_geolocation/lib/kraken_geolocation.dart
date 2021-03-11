import 'package:flutter/widgets.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken/bridge.dart';
import 'package:kraken/module.dart';
import 'package:kraken_geolocation/geolocation_module.dart';
import 'platform.dart';
import 'dart:ffi';

typedef Native_InitBridge = Void Function();
typedef Dart_InitBridge = void Function();

final Dart_InitBridge _initBridge =
nativeDynamicLibrary.lookup<NativeFunction<Native_InitBridge>>('initBridge').asFunction();

void initBridge() {
  _initBridge();
}

class KrakenGeolocation {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    ModuleManager.defineModule((moduleManager) => GeolocationModule(moduleManager));
  }
}