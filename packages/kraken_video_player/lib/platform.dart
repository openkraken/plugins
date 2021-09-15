/*
 * Copyright (C) 2019-present Alibaba Inc. All rights reserved.
 * Author: Kraken Team.
 */
// ignore_for_file: unused_import, undefined_function

import 'dart:ffi';
import 'dart:io' show Platform;
import 'dart:typed_data';

/// Search dynamic lib from env.KRAKEN_LIBRARY_PATH or /usr/lib
const String KRAKEN_JS_ENGINE = 'KRAKEN_JS_ENGINE';
final String kkJsEngine = Platform.environment[KRAKEN_JS_ENGINE] ??
    ((Platform.isIOS || Platform.isMacOS || Platform.isAndroid) ? 'quickjs' : 'jsc');
final String libName = 'libkraken_video_player_$kkJsEngine';
final String nativeDynamicLibraryName = (Platform.isMacOS)
    ? '$libName.dylib'
    : Platform.isIOS ? 'kraken_video_player.framework/kraken_video_player'  :  Platform.isWindows ? '$libName.dll' : '$libName.so';
DynamicLibrary nativeDynamicLibrary =
    DynamicLibrary.open(nativeDynamicLibraryName);