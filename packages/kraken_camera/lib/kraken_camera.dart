import 'package:kraken/dom.dart';
import 'camera_element.dart';

class KrakenCamera {
  static void initialize() {
    defineElement('CAMERA-PREVIEW',
        (EventTargetContext? context) => CameraPreviewElement(context));
  }
}
