import 'package:flutter/widgets.dart';
import 'animation_player_element.dart';
import 'package:kraken/dom.dart';
import 'platform.dart';
import 'dart:ffi';

typedef Native_InitBridge = Void Function();
typedef Dart_InitBridge = void Function();

final Dart_InitBridge _initBridge =
nativeDynamicLibrary.lookup<NativeFunction<Native_InitBridge>>('initBridge').asFunction();

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
