// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/widgets.dart';
import 'package:kraken/module.dart';
import 'package:kraken/launcher.dart';
import 'package:kraken/bridge.dart';
import 'mqtt_module.dart';

class KrakenMQTT {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    ModuleManager.defineModule((moduleNamager) => MQTTModule(moduleNamager));
    KrakenBundle.getBundle('packages/kraken_mqtt/assets/mqtt.js').then((KrakenBundle bundle) {
      patchKrakenPolyfill(bundle.content, 'kraken_mqtt://');
    });
  }
}
