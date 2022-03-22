import 'package:kraken/dom.dart';
import 'video_element.dart';

class KrakenVideoPlayer {
  static void initialize() {
    defineElement(
        'VIDEO', (context) => VideoElement(context));
  }
}
