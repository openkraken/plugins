import 'animation_player_element.dart';
import 'package:kraken/dom.dart';

class KrakenAnimationPlayer {
  static void initialize() {
    defineElement(
        'ANIMATION-PLAYER', (context) => AnimationPlayerElement(context));
  }
}
