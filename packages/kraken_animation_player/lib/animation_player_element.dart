/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */

import 'dart:collection';
import 'dart:ffi';
import 'package:flutter/services.dart';
import 'package:kraken/kraken.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/rendering.dart';
import 'package:kraken/css.dart';
import 'package:kraken/dom.dart';
import 'package:kraken/launcher.dart';
import 'flare_render_object.dart';

const String ANIMATION_PLAYER = 'ANIMATION-PLAYER';
const String ANIMATION_TYPE_FLARE = 'flare';

final Map<String, dynamic> _defaultStyle = {
  DISPLAY: BLOCK,
  WIDTH: ELEMENT_DEFAULT_WIDTH,
  HEIGHT: ELEMENT_DEFAULT_HEIGHT,
};

// Ref: https://github.com/LottieFiles/lottie-player
class AnimationPlayerElement extends Element {
  FlareRenderObject? _animationRenderObject;
  FlareControls? _animationController;

  AnimationPlayerElement(BindingContext? context)
      : super(context,
            defaultStyle: _defaultStyle,
            isReplacedElement: true,
            isDefaultRepaintBoundary: true) {}

  String get objectFit => style[OBJECT_FIT];

  // Default type to flare
  String get type => attributes['type'] ?? ANIMATION_TYPE_FLARE;

  String? get src => attributes['src'];

  @override
  void willAttachRenderer() {
    super.willAttachRenderer();

    _animationRenderObject = _createFlareRenderObject();
    if (_animationRenderObject != null) {
      addChild(_animationRenderObject!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  getBindingProperty(String key) {
    switch (key) {
      case 'play':
        return play;
    }

    return super.getBindingProperty(key);
  }

  @override
  void didDetachRenderer() {
    _animationRenderObject = null;
  }

  void play(List<dynamic> args) {
    if (args.length == 1) {
      _animationController?.play(args[0]);
    } else if (args.length == 2) {
      _animationController?.play(args[0], mix: args[1]);
    } else if (args.length == 3) {
      _animationController?.play(args[0], mix: args[1], mixSeconds: args[2]);
    }
  }

  void _updateObjectFit() {
    if (_animationRenderObject is FlareRenderObject) {
      FlareRenderObject renderBox = _animationRenderObject!;
      renderBox.fit = _getObjectFit();
    }
  }

  @override
  void setRenderStyle(String key, value) {
    super.setRenderStyle(key, value);
    if (key == OBJECT_FIT) {
      _updateObjectFit();
    }
  }

  BoxFit _getObjectFit() {
    switch (objectFit) {
      case 'fill':
        return BoxFit.fill;
      case 'cover':
        return BoxFit.cover;
      case 'fit-height':
        return BoxFit.fitHeight;
      case 'fit-width':
        return BoxFit.fitWidth;
      case 'scale-down':
        return BoxFit.scaleDown;
      case 'contain':
      default:
        return BoxFit.contain;
    }
  }

  FlareRenderObject? _createFlareRenderObject() {
    if (src == null) {
      return null;
    }

    BoxFit boxFit = _getObjectFit();
    _animationController = FlareControls();

    return FlareRenderObject()
      ..assetProvider =
          AssetFlare(bundle: NetworkAssetBundle(Uri.parse(src!)), name: '')
      ..fit = boxFit
      ..alignment = Alignment.center
      ..animationName = attributes['name']
      ..shouldClip = false
      ..useIntrinsicSize = true
      ..controller = _animationController;
  }
}
