import 'animation_player_element.dart';
import 'package:kraken/dom.dart';
import 'platform.dart';
import 'dart:ffi';

typedef NativeInitBridge = Void Function();
typedef DartInitBridge = void Function();

final DartInitBridge _initBridge = nativeDynamicLibrary
    .lookup<NativeFunction<NativeInitBridge>>('initBridge')
    .asFunction();

void initBridge() {
  _initBridge();
}

class KrakenAnimationPlayer {
  static void initialize() {
    initBridge();
    ElementManager.defineElement(
        'ANIMATION-PLAYER',
        (id, nativePtr, elementManager) => AnimationPlayerElement(
            id, nativePtr.cast<NativeAnimationElement>(), elementManager));
  }
}
