/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

import 'package:kraken/bridge.dart';

import 'package:kraken/dom.dart';
import 'iframe_element.dart';

class KrakenWebView {
  static void initialize() {
    ElementManager.defineElement('IFRAME', (id, nativePtr, elementManager) {
      return IFrameElement(
          id, nativePtr.cast<NativeEventTarget>(), elementManager);
    });
  }
}
