#
# Be sure to run `pod lib lint YEXSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YEXSwift'
  s.version          = '0.0.8'
  s.summary          = 'A short description of YEXSwift.'
  s.description      = <<-DESC
                        常用扩展,基类
                       DESC

  s.homepage         = 'https://github.com/1091676312@qq.com/YEXSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1091676312@qq.com' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/yijingKing/YEXSwift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'YEXSwift/Classes/**/*'
  s.dependency 'MJRefresh'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'SnapKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  # s.resource_bundles = {
  #   'YEXSwift' => ['YEXSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
