Pod::Spec.new do |s|
  s.name             = 'YEXSwift'
  s.version          = '0.0.2'
  s.summary          = 'YEXKit 扩展,功能集合'
  s.description      = <<-DESC
                            ...
                       DESC

  s.homepage         = 'https://github.com/yijingKing/YEXSwift.git'
  #s.license         = { :type => 'MIT', :file => 'LICENSE' }
  s.license          = 'MIT'
  s.author           = { '╰莪呮想好好宠Nǐつ ' => '1091676312@qq.com' }
  s.source           = { :git => 'https://github.com/yijingKing/YEXSwift.git', :tag => s.version.to_s }
  #s.pod_target_xcconfig = {'SWIFT_VERSION' => '5.0'}
  s.swift_versions   = '5.0'
  s.platform         = :ios, "11.0"
  s.frameworks       = 'UIKit','Foundation','Photos'
  s.dependency 'MJRefresh'
  s.dependency 'DZNEmptyDataSet'
  
  #s.resource_bundles = { 'YEXResources' => 'YEXSwift/Resource/*' }
  
  s.source_files = 'YEXSwift/**/*.swift'

s.requires_arc = true
end
