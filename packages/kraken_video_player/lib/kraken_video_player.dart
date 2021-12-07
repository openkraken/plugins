import 'package:kraken/dom.dart';
import 'video_element.dart';

class KrakenVideoPlayer {
  static void initialize() {
    defineElement('VIDEO', (EventTargetContext context) => VideoElement(context));
  }
}