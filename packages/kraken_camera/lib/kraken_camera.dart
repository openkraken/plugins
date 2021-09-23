import 'package:kraken/bridge.dart';
import 'package:kraken/dom.dart';
import 'camera_element.dart';

class KrakenCamera {
  static void initialize() {
    ElementManager.defineElement(
        'CAMERA-PREVIEW',
        (id, nativePtr, elementManager) => CameraPreviewElement(
            id, nativePtr.cast<NativeEventTarget>(), elementManager));
  }
}
