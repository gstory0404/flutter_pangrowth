#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_pangrowth.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_pangrowth'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'gstory' => 'gstory0404@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.exclude_files = 'buadsdk.xcframework'
  s.dependency 'MJExtension','3.4.0'
  s.dependency 'Ads-CN', '6.4.1.7'
  s.dependency 'Pangrowth/media-dynamic','5.1.0.0'
  s.dependency 'PangrowthX/ministory','2.2.0.2'
  s.dependency 'PangrowthX/shortplay-lite','2.2.0.2'

#   # Base
#   s.dependency 'RangersApplog', '6.17.0'
#   s.dependency 'RangersAPM', '5.1.3'
#   # shortplay
#   s.dependency 'PangrowthDJX-lite', '2.2.0.2'
#   s.dependency 'PGXToolbox', '2.2.0.2'
#   # ministory
#   s.dependency 'PangrowthMiniStory', '2.2.0.2'
#   s.dependency 'PGXToolbox', '2.2.0.2'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
#  s.swift_version = '5.0'
end
