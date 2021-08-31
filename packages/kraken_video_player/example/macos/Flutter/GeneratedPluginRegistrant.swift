//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import connectivity_macos
import kraken
import kraken_video_player
import shared_preferences_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  ConnectivityPlugin.register(with: registry.registrar(forPlugin: "ConnectivityPlugin"))
  KrakenPlugin.register(with: registry.registrar(forPlugin: "KrakenPlugin"))
  FLTKrakenVideoPlayerPlugin.register(with: registry.registrar(forPlugin: "FLTKrakenVideoPlayerPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
}
