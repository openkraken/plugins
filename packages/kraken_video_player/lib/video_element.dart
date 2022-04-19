/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:kraken/css.dart';
import 'package:kraken/dom.dart';
import 'package:kraken/foundation.dart';
import 'package:kraken/rendering.dart';

import 'video_player.dart';
import 'media_element.dart';

const String VIDEO = 'VIDEO';

const Map<String, dynamic> _defaultStyle = {
  DISPLAY: INLINE_BLOCK,
  WIDTH: ELEMENT_DEFAULT_WIDTH,
  HEIGHT: ELEMENT_DEFAULT_HEIGHT,
};

class VideoElement extends MediaElement {
  VideoElement(context) : super(context, defaultStyle: _defaultStyle);

  @override
  void willAttachRenderer() {
    super.willAttachRenderer();
    renderVideo();
  }

  @override
  void didDetachRenderer() {
    super.didDetachRenderer();
    _textureBox = null;

    if (controller != null) {
      controller!.dispose().then((_) {
        controller = null;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  void renderVideo() {
    _textureBox = TextureBox(textureId: 0);
    if (childNodes.isEmpty) {
      addChild(_textureBox!);
    }
  }

  TextureBox? _textureBox;
  VideoPlayerController? controller;

  String? _src;
  String? get src => _src;
  set src(String? value) {
    if (_src != value) {
      bool needDispose = _src != null;
      _src = value;

      if (needDispose) {
        controller!.dispose().then((_) {
          _removeVideoBox();
          _createVideoBox();
        });
      } else {
        _createVideoBox();
      }
    }
  }

  bool _loop = false;
  bool get loop => _loop;
  set loop(bool value) {
    _loop = value;
    controller?.setLooping(_loop);
  }

  bool _muted = false;
  bool get muted => _muted;
  set muted(bool value) {
    _muted = value;
    controller?.setMuted(_muted);
  }

  bool _autoplay = false;
  bool get autoplay => _autoplay;
  set autoplay(bool value) {
    _autoplay = value;
  }

  int get currentTime => controller?.value.position.inSeconds ?? -1;
  set currentTime(int value) {
    controller?.seekTo(Duration(seconds: value));
  }

  double get videoWidth => controller?.value.size!.width ?? 0;

  double get videoHeight => controller?.value.size!.height ?? 0;

  Future<int> createVideoPlayer(String src) {
    Completer<int> completer = Completer();

    if (src.startsWith('//') || src.startsWith('http://') || src.startsWith('https://')) {
      controller = VideoPlayerController.network(src.startsWith('//') ? 'https:' + src : src);
    } else if (src.startsWith('file://')) {
      controller = VideoPlayerController.file(src);
    } else {
      // Fallback to asset video
      controller = VideoPlayerController.asset(src);
    }

    _src = src;

    controller!.setLooping(loop);
    controller!.onCanPlay = onCanPlay;
    controller!.onCanPlayThrough = onCanPlayThrough;
    controller!.onPlay = onPlay;
    controller!.onPause = onPause;
    controller!.onSeeked = onSeeked;
    controller!.onSeeking = onSeeking;
    controller!.onEnded = onEnded;
    controller!.onError = onError;
    controller!.initialize().then((int textureId) {
      controller!.setMuted(muted);

      completer.complete(textureId);
    });

    return completer.future;
  }

  void addVideoBox(int textureId) {
    if (_src == null) {
      return;
    }

    TextureBox box = TextureBox(textureId: textureId);

    addChild(box);

    if (_autoplay) {
      controller!.play();
    }
  }

  void _createVideoBox() {
    createVideoPlayer(_src!).then(addVideoBox);
  }

  void _removeVideoBox() {
    (renderBoxModel as RenderReplaced).child = null;
  }

  onCanPlay() async {
    Event event = Event(EVENT_CAN_PLAY, EventInit());
    dispatchEvent(event);
  }

  onCanPlayThrough() async {
    Event event = Event(EVENT_CAN_PLAY_THROUGH, EventInit());
    dispatchEvent(event);
  }

  onEnded() async {
    Event event = Event(EVENT_ENDED, EventInit());
    dispatchEvent(event);
  }

  onError(int code, String? error) {
    Event event = MediaError(code, error!);
    dispatchEvent(event);
  }

  onPause() async {
    Event event = Event(EVENT_PAUSE, EventInit());
    dispatchEvent(event);
  }

  onPlay() async {
    Event event = Event(EVENT_PLAY, EventInit());
    dispatchEvent(event);
  }

  onSeeked() async {
    Event event = Event(EVENT_SEEKED, EventInit());
    dispatchEvent(event);
  }

  onSeeking() async {
    Event event = Event(EVENT_SEEKING, EventInit());
    dispatchEvent(event);
  }

  onVolumeChange() async {
    Event event = Event(EVENT_VOLUME_CHANGE, EventInit());
    dispatchEvent(event);
  }

  @override
  void play() {
    controller?.play();
  }

  @override
  void pause() {
    controller?.pause();
  }

  @override
  void fastSeek(double duration) {
    controller?.seekTo(Duration(seconds: duration.toInt()));
  }

  @override
  void setAttribute(String key, String value) {
    super.setAttribute(key, value);
    switch (key) {
      case 'src': src = attributeToProperty<String>(value); break;
      case 'loop': loop = attributeToProperty<bool>(value); break;
      case 'currentTime': currentTime = attributeToProperty<int>(value); break;
    }
  }

  @override
  void setBindingProperty(String key, value) {
    switch (key) {
      case 'src': src = castToType<String>(value); break;
      case 'loop': loop = castToType<bool>(value); break;
      case 'autoplay': autoplay = castToType<bool>(value); break;
      case 'currentTime': currentTime = castToType<num>(value).toInt(); break;
      default: super.setBindingProperty(key, value);
    }
  }

  void _bindingPlay(List args) {
    play();
  }

  void _bindingPause(List args) {
    pause();
  }

  void _bindingFastSeek(List args) {
    fastSeek(castToType<double>(args[0]));
  }

  @override
  getBindingProperty(String key) {
    switch (key) {
      case 'play': return _bindingPlay;
      case 'pause': return _bindingPause;
      case 'fastSeek': return _bindingFastSeek;
      case 'autoplay': return autoplay;
      case 'loop': return loop;
      case 'currentTime': return currentTime;
      case 'src': return src;
      case 'width': return videoWidth;
      case 'height': return videoHeight;
      default: return super.getBindingProperty(key);
    }
  }
}
