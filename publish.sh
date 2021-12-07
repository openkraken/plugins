ROOT=$(pwd)

publish() {
  cd $ROOT/packages/$1
  flutter pub publish --force
  echo "publish $1"
  cd $ROOT
}

build_and_publish() {
  cd $ROOT/packages/$1
  flutter pub get
  rm -f $ROOT/packages/$1/ios/$1.xcframework
  kraken-npbt clean
  kraken-npbt configure
  kraken-npbt build
  flutter pub publish --force
  cd $ROOT
}

publish kraken_animation_player
publish kraken_camera
publish kraken_video_player
build_and_publish kraken_websocket
publish kraken_webview