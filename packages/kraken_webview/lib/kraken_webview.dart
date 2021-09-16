/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

import 'dart:ffi';
import 'package:kraken/bridge.dart';

import 'platform.dart';
import 'package:kraken/dom.dart';
import 'iframe_element.dart';

typedef Native_InitBridge = Void Function();
typedef Dart_InitBridge = void Function();

final Dart_InitBridge _initBridge = nativeDynamicLibrary
    .lookup<NativeFunction<Native_InitBridge>>('initBridge')
    .asFunction();

void initBridge() {
  _initBridge();
}

class KrakenWebView {
  static void initialize() {
    initBridge();
    ElementManager.defineElement('IFRAME', (id, nativePtr, elementManager) {
      return IFrameElement(
          id, nativePtr.cast<NativeEventTarget>(), elementManager);
    });
  }
}
