# kraken_websocket

W3C compact WebSocket API support.


## Installation

First, add kraken_websocket as a dependency in your pubspec.yaml file.

Second, add the following code before calling runApp():

```dart
import 'package:kraken_websocket/kraken_websocket.dart';
void main() {
  runApp(MyApp());
  KrakenWebsocket.initialize();
}
```

## Example

```javascript
let ws = new WebSocket('ws://127.0.0.1:8399');
ws.onopen = () => {
    ws.send('helloworld');
};
ws.onmessage = (event) => {
    console.log(event);
}
```

## Contribute

convert javascript code to quickjs bytecode:

```bash
kraken qjsc ./lib/websocket.js ./lib/websocket_qjsc.dart --dart
```