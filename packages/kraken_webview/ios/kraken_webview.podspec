#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'kraken_webview'
  s.version          = '0.0.1'
  s.summary          = 'A WebView Plugin for Flutter.'
  s.description      = <<-DESC
A WebView Plugin for Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.vendored_libraries = 'libkraken_webview_jsc.dylib'
  s.platform = :ios, '8.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
