# kraken_animation_player

A kraken plugin which provide `<animation-player />` tags to play animation format files.

Support format:

1. [Flare](https://github.com/2d-inc)

## Installation

First, add `kraken_animation_player` as a dependency in your pubspec.yaml file.

Second, add the following code before calling `runApp()`:

```dart
import 'package:kraken_animation_player/kraken_animation_player.dart';

void main() {
  KrakenAnimationPlayer.initialize();
  runApp(MyApp());
}
```

## Example

```javascript
const ASSET = 'https://kraken.oss-cn-hangzhou.aliyuncs.com/data/Teddy.flr';
const animationPlayer = document.createElement('animation-player');
animationPlayer.setAttribute('type', 'flare');
animationPlayer.setAttribute('src', ASSET);
Object.assign(animationPlayer.style, {
  width: '360px',
  height: '640px',
  objectFit: 'contain',
});

document.body.appendChild(animationPlayer);
document.body.onclick = () => animationPlayer.play('hands_up');
```

