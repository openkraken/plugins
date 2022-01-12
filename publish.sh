ROOT=$(pwd)

publish() {
  cd $ROOT/packages/$1
  flutter pub publish --force
  echo "publish $1"
  cd $ROOT
}

publish kraken_animation_player
publish kraken_camera
publish kraken_video_player
publish kraken_websocket
publish kraken_webview