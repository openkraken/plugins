import 'package:kraken/dom.dart';
import 'camera_element.dart';

class KrakenCamera {
  static void initialize() {
    defineElement('CAMERA-PREVIEW', (context) => CameraPreviewElement(context));
  }
}
