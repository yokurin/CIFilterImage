#
#  Be sure to run `pod spec lint CIFilterImage.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "CIFilterImage"
  s.version      = "0.0.1"
  s.summary      = "CIFilterImage provides UI that can be easily filter images. This is wrapper of CIFilter."

  s.description  = <<-DESC
                  CIFilterImage provides UI that can be easily filter images.  
                  This is wrapper of CIFilter.
                   DESC

  s.homepage     = "https://github.com/yokurin/CIFilterImage"
  # s.screenshots  = "https://github.com/yokurin/CIFilterImage/blob/master/READMEResorces/white.gif", "https://github.com/yokurin/CIFilterImage/blob/master/READMEResorces/black.gif"

  s.license      = { :type => "MIT", :file => "./LICENSE" }
  s.author       = { "Tsubasa Hayashi" => "yoku.rin.99@gmail.com" }
  s.social_media_url = "http://twitter.com/_yokurin"
  s.source       = { :git => "https://github.com/yokurin/CIFilterImage.git", :tag => "#{s.version}" }
  s.platform = :ios
  s.ios.deployment_target = '11.4'
  s.swift_version = '5.0'
  s.source_files  = 'CIFilterImage/**/*.swift'
end
