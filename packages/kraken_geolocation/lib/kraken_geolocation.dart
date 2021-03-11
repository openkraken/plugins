import 'package:flutter/widgets.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken/bridge.dart';
import 'package:kraken/module.dart';
import 'package:kraken_geolocation/geolocation_module.dart';

class KrakenGeolocation {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    ModuleManager.defineModule((moduleManager) => GeolocationModule(moduleManager));
    KrakenBundle.getBundle('packages/kraken_geolocation/assets/geolocation.js').then((KrakenBundle bundle) {
      patchKrakenPolyfill(bundle.content, 'kraken_geolocation://');
    });
  }
}