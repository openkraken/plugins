import 'animation_player_element.dart';
import 'package:kraken/dom.dart';

class KrakenAnimationPlayer {
  static void initialize() {
    ElementManager.defineElement(
        'ANIMATION-PLAYER',
        (id, nativePtr, elementManager) => AnimationPlayerElement(
            id, nativePtr, elementManager));
  }
}
