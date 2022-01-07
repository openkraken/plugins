import 'websocket_module.dart';
import 'package:kraken/module.dart';
import 'package:kraken/bridge.dart';
import 'websocket_qjsc.dart';

class KrakenWebsocket {
  static void initialize() {
    print(byteData);
    registerPluginByteCode(byteData, 'kraken_websocket');
    ModuleManager.defineModule((moduleNamager) => WebSocketModule(moduleNamager));
  }
}
