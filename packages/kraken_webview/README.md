# kraken_webview

kraken `<iframe />` tags support.

## Installation

First, add kraken_frame as a dependency in your pubspec.yaml file.

Second, add the following code before calling runApp():

```dart
void main() {
  KrakenWebView.initialize();
  runApp(MyApp());
}
```

## Example

```javascript
const iframe = document.createElement('iframe');
iframe.setAttribute(
    'src',
    'https://dev.g.alicdn.com/kraken/kraken-demos/todomvc/build/web/index.html'
);
iframe.style.width = '360px';
iframe.style.height = '375px';
document.body.appendChild(iframe);
```

## Development

**Building Bridge for macos**

```shell
cd bridge/scripts
./build_macos.sh
```

**Building Bridge for ios**
```shell
cd bridge/scripts
./build_ios.sh
```

**Building Bridge for Android**

requirement: Android SDK installed at `~/Library/Android/sdk`

NDK version requirement: 20.0.5594570

```shell
cd bridge/scripts
./build_android.sh
```