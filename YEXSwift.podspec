#
# Be sure to run `pod lib lint YEXSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YEXSwift'
  s.version          = '0.0.9'
  s.summary          = 'A short description of YEXSwift.'
  s.description      = <<-DESC
                        常用扩展,基类
                       DESC

  s.homepage         = 'https://github.com/1091676312@qq.com/YEXSwift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1091676312@qq.com' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/yijingKing/YEXSwift.git', :tag => s.version.to_s }

  s.swift_versions   = '5.0'
  s.platform         = :ios, "11.0"
  
  s.dependency 'MJRefresh'
  s.dependency 'SnapKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.resource_bundles = {
      'YEXSwift' => ['YEXSwift/Assets/*.png']
  }

  s.source_files = 'YEXSwift/Classes/**/*'
#
#  s.subspec 'Base' do |sp|
#        sp.source_files = 'YEXSwift/Classes/Base/**/*'
#        sp.source_files = 'YEXSwift/Classes/Extension/**/*'
#        sp.source_files = 'YEXSwift/Classes/Other/**/*'
#    end
#  s.subspec 'Extension' do |sp|
#        sp.source_files = 'YEXSwift/Classes/Other/**/*'
#        sp.source_files = 'YEXSwift/Classes/Extension/**/*'
#    end
#  s.subspec 'Other' do |sp|
#        sp.source_files = 'YEXSwift/Classes/Other/**/*'
#    end
  
end
