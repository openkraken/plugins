
import 'package:flutter/widgets.dart';
import 'websocket_module.dart';
import 'package:kraken/launcher.dart';
import 'package:kraken/module.dart';
import 'package:kraken/bridge.dart';

class KrakenWebsocket {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    ModuleManager.defineModule((moduleNamager) => WebSocketModule(moduleNamager));
    KrakenBundle.getBundle('packages/kraken_websocket/assets/websocket.js').then((KrakenBundle bundle) {
      // print(bundle.content);
      patchKrakenPolyfill(bundle.content, 'kraken_websocket://');
    });
  }
}
