import 'package:kraken/dom.dart';

abstract class MediaElement extends Element {
  MediaElement(EventTargetContext? context,
      {required Map<String, dynamic> defaultStyle})
      : super(context,
            isReplacedElement: true,
            isDefaultRepaintBoundary: true,
            defaultStyle: defaultStyle) {}

  @override
  getProperty(String key) {
    switch (key) {
      case 'play':
        return (List<dynamic> argv) => play();
      case 'pause':
        return (List<dynamic> args) => pause();
      case 'fastSeek':
        return (List<dynamic> argv) => fastSeek(argv[0]);
    }
    return super.getProperty(key);
  }

  void play();

  void pause();

  void fastSeek(double duration);
}
