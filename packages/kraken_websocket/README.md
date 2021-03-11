# kraken_websocket

W3C compact WebSocket API support.


## Installation

First, add kraken_websocket as a dependency in your pubspec.yaml file.

Second, add the following code before calling runApp():

```dart
import 'package:kraken_websocket/kraken_websocket.dart';
void main() {
  KrakenWebsocket.initialize();
  runApp(MyApp());
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