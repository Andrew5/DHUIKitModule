#
# Be sure to run `pod lib lint DHUIKitModule.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DHUIKitModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DHUIKitModule.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/jabraknight/DHUIKitModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jabraknight' => 'localhost3585@gmail.com' }
  s.source           = { :git => 'https://github.com/jabraknight/DHUIKitModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

#  s.resource = 'DHUIKitModule/Assets/*'
  
  s.source_files = 'DHUIKitModule/Classes/**/*'
  s.dependency 'lottie-ios','~> 2.5.3'

   s.resource_bundles = {
     'DHProgressHUD' => ['DHUIKitModule/Assets/*.{png,json,imageset}']
   }
   # 这种是帮你打包成bundle
   # s.resource_bundles = {
   #   "#{s.name}" => ["#{s.name}/Assets/*.{png,xib,plist}"]
   # }
   # 这种是你已经打包好了bundle，推荐这种，可以省去每次pod帮你生成bundle的时间
   # s.resources = "#{s.name}/Assets/*.bundle"

   
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
