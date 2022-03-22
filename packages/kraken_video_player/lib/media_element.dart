import 'package:kraken/dom.dart';

abstract class MediaElement extends Element {
  MediaElement(context,
      {required Map<String, dynamic> defaultStyle})
      : super(context, isReplacedElement: true,
            isDefaultRepaintBoundary: true,
            defaultStyle: defaultStyle);

  void play();

  void pause();

  void fastSeek(double duration);
}
