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
final String libName = 'kraken_video_player';
final String nativeDynamicLibraryName = (Platform.isMacOS)
    ? 'lib$libName.dylib'
    : Platform.isIOS ? '$libName.framework/$libName' : Platform.isWindows ? '$libName.dll' : 'lib$libName.so';
DynamicLibrary nativeDynamicLibrary =
DynamicLibrary.open(nativeDynamicLibraryName);