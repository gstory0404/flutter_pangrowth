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
  s.dependency 'MJExtension','~> 3.4.0'
  s.dependency 'Pangrowth/media','~> 3.9.0.4'
 # s.dependency 'Pangrowth/novel','~> 3.9.0.1'
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
#  s.swift_version = '5.0'
end
