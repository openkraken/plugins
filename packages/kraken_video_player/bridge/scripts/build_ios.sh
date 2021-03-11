ROOT=$(pwd)

export KRAKEN_JS_ENGINE=jsc

## Build for simulator
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_TOOLCHAIN_FILE=$ROOT/../cmake/ios.toolchain.cmake \
  -DPLATFORM=SIMULATOR64 \
  -DENABLE_BITCODE=FALSE -G "Unix Makefiles" \
  -B $ROOT/cmake-build-ios-x64 -S $ROOT/../

cmake --build $ROOT/cmake-build-ios-x64 --target kraken_video_player -- -j 12


## Build for ARMv7
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_TOOLCHAIN_FILE=$ROOT/../cmake/ios.toolchain.cmake \
  -DPLATFORM=OS \
  -DENABLE_BITCODE=FALSE -G "Unix Makefiles" \
  -B $ROOT/cmake-build-arm -S $ROOT/../

cmake --build $ROOT/cmake-build-arm  --target kraken_video_player -- -j 12

## Build for ARM64
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_TOOLCHAIN_FILE=$ROOT/../cmake/ios.toolchain.cmake \
  -DPLATFORM=OS64 \
  -DENABLE_BITCODE=FALSE -G "Unix Makefiles" \
  -B $ROOT/cmake-build-arm64 -S $ROOT/../

cmake --build $ROOT/cmake-build-arm64 --target kraken_video_player -- -j 12

X86_SDK_PATH=$ROOT/cmake-build-ios-x64/libkraken_video_player_jsc.dylib
ARMv7_SDK_PATH=$ROOT/cmake-build-arm/libkraken_video_player_jsc.dylib
ARMv8_SDK_PATH=$ROOT/cmake-build-arm64/libkraken_video_player_jsc.dylib

TARGET_SDK_PATH=$ROOT/../../ios/libkraken_video_player_jsc.dylib

lipo -create $X86_SDK_PATH $ARMv7_SDK_PATH $ARMv8_SDK_PATH -output $TARGET_SDK_PATH
dsymutil $TARGET_SDK_PATH
strip -S -X -x $TARGET_SDK_PATH