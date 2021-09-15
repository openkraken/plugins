import 'dart:ffi';
import 'package:kraken/bridge.dart';
import 'package:kraken/dom.dart';

abstract class MediaElement extends Element {
  MediaElement(int targetId, Pointer<NativeEventTarget> nativePtr,
      ElementManager elementManager, String tagName,
      {required Map<String, dynamic> defaultStyle})
      : super(targetId, nativePtr, elementManager,
            isIntrinsicBox: true,
            tagName: tagName,
            repaintSelf: true,
            defaultStyle: defaultStyle) {
  }

  @override
  handleJSCall(String method, List argv) {
    switch(method) {
      case 'play':
        return (List<dynamic> args) {
          play();
          return null;
        };
      case 'pause':
        return (List<dynamic> args) {
          pause();
          return null;
        };
      case 'fastSeek':
        return (List<dynamic> args) {
          fastSeek(argv[0]);
          return null;
        };
      default:
        return super.handleJSCall(method, argv);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void play();

  void pause();

  void fastSeek(double duration);
}
