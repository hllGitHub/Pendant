#
# Be sure to run `pod lib lint Pendant.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Pendant'
  s.version          = '0.1.0'
  s.summary          = 'Development toolset.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '用 Swift 编写的开发工具集，包含了一些常用类和方法'

  s.homepage         = 'https://github.com/hllGitHub/Pendant'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liangliang.hu' => 'hllfj922@gmail.com' }
  s.source           = { :git => 'https://github.com/hllGitHub/Pendant.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Pendant/Classes/**/*'
  
end
