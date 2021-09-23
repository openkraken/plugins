import 'package:kraken/bridge.dart';
import 'package:kraken/dom.dart';
import 'video_element.dart';

class KrakenVideoPlayer {
  static void initialize() {
    ElementManager.defineElement(
        'VIDEO',
        (id, nativePtr, elementManager) => VideoElement(
            id, nativePtr.cast<NativeEventTarget>(), elementManager));
  }
}