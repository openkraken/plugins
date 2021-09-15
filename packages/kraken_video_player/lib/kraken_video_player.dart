import 'package:flutter/widgets.dart';
import 'package:kraken/bridge.dart';
import 'package:kraken/dom.dart';
import 'dart:ffi';
import 'video_element.dart';
import 'platform.dart';

typedef Native_InitBridge = Void Function();
typedef Dart_InitBridge = void Function();

final Dart_InitBridge _initBridge =
nativeDynamicLibrary.lookup<NativeFunction<Native_InitBridge>>('initBridge').asFunction();

void initBridge() {
  _initBridge();
}

class KrakenVideoPlayer {
  static void initialize() {
    initBridge();
    ElementManager.defineElement(
        'VIDEO',
        (id, nativePtr, elementManager) => VideoElement(
            id, nativePtr.cast<NativeEventTarget>(), elementManager));
  }
}