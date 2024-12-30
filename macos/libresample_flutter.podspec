#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint libresample_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'libresample_flutter'
  s.version          = '0.0.1'
  s.summary          = 'An ffi plugin for libresample'
  s.description      = <<-DESC
A Flutter ffi plugin for the audio resampler package libresample
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = ['Classes/**/*']
  s.public_header_files = 'Classes/LibresampleFlutterPlugin.h'
  s.swift_version = '5.0'
  
  s.dependency 'FlutterMacOS'
  s.osx.deployment_target = '10.14'
end
