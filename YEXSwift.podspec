Pod::Spec.new do |s|
    s.name             = 'YEXSwift'
    s.version          = '2.0.0'
    s.summary          = 'A short description of YEXSwift.'
    s.description      = <<-DESC
    常用扩展,基类
    DESC
    
    s.homepage         = 'https://github.com/1091676312@qq.com/YEXSwift'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { '╰莪呮想好好宠Nǐつ' => '1091676312@qq.com' }
    s.source           = { :git => 'https://github.com/yijingKing/YEXSwift.git', :tag => s.version.to_s }
    
    s.swift_versions   = '5.0'
    s.platform         = :ios, "13.0"
    
    # 主库，包含所有代码
    s.source_files = 'YEXSwift/Classes/**/*'
    s.dependency 'MJRefresh'
        s.dependency 'SnapKit'
        s.dependency 'RxSwift'
        s.dependency 'RxCocoa'
end
