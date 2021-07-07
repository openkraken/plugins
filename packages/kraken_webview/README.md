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

## Contribute
Install kraken-npbt

```
npm install kraken-npbt -g
```

Generate build project files:

```
kraken-npbt configure
```

Build native dynamic library

```
kraken-npbt build
```