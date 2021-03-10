
import 'package:flutter/widgets.dart';
import 'package:kraken/bridge.dart';
import 'package:kraken/dom.dart';
import 'camera_element.dart';

class KrakenCamera {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    ElementManager.defineElement(
        'ANIMATION-PLAYER',
            (id, nativePtr, elementManager) => CameraPreviewElement(
            id, nativePtr.cast<NativeElement>(), elementManager));
  }
}
