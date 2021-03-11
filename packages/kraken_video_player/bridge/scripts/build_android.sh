ROOT=$(pwd)

export KRAKEN_JS_ENGINE=jsc
NDK_PATH=$HOME/Library/Android/sdk/ndk/20.0.5594570

## Build ARM64
cmake -DCMAKE_BUILD_TYPE=relwithdebinfo -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
    -DANDROID_NDK=$NDK_PATH \
    -DIS_ANDROID=TRUE \
    -DANDROID_ABI="arm64-v8a" \
    -DANDROID_PLATFORM="android-16" \
    -DANDROID_STL=c++_shared \
    -G "Unix Makefiles" \
    -B $ROOT/cmake-build-android-arm64 -S $ROOT/../

cmake --build $ROOT/cmake-build-android-arm64 --target kraken_video_player -- -j 12

## Build ARMv7
cmake -DCMAKE_BUILD_TYPE=relwithdebinfo -DCMAKE_TOOLCHAIN_FILE=$NDK_PATH/build/cmake/android.toolchain.cmake \
    -DANDROID_NDK=$NDK_PATH \
    -DIS_ANDROID=TRUE \
    -DANDROID_ABI="armeabi-v7a" \
    -DANDROID_PLATFORM="android-16" \
    -DANDROID_STL=c++_shared \
    -G "Unix Makefiles" \
    -B $ROOT/cmake-build-android-arm -S $ROOT/../

cmake --build $ROOT/cmake-build-android-arm --target kraken_video_player -- -j 12
