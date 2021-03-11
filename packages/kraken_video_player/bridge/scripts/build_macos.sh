ROOT=$(pwd)

export KRAKEN_JS_ENGINE=jsc

cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -G "Unix Makefiles" -B $ROOT/cmake-build-relwithdebuginfo -S $ROOT/../
cmake --build $ROOT/cmake-build-relwithdebuginfo --target kraken_video_player -- -j 12

BINARY_PATH=$ROOT/../../macos/libkraken_video_player_jsc.dylib

dsymutil $BINARY_PATH
strip -S -X -x $BINARY_PATH