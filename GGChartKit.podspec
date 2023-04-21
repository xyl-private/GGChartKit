#
#  Be sure to run `pod spec lint YLCharts.podspec" to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "GGChartKit" # 项目名称
  s.version      = "0.0.1"        # 版本号 与 你仓库的 标签号 对应
  s.license      = { :type => "MIT", :file => "LICENSE" }   # 开源证书
  s.summary      = "基于GGCharts的封装" # 项目简介

  s.homepage     = "https://github.com/xyl-private/GGChartKit" # 你的主页
  s.source       = { :git => https://github.com/xyl-private/GGChartKit.git", :tag => "#{s.version}" }#你的仓库地址，不能用SSH地址
  
  #s.public_header_files = "GGChartKit/*.h"
  s.source_files  = "GGChartKit/**/*.{h,m}"
  
   s.ios.deployment_target = "12.0"
  
  s.requires_arc = true # 是否启用ARC
  #s.platform     = :ios, "12.0" #平台及支持的最低版本
  #s.frameworks   = "UIKit", "Foundation", "libc++" #支持的框架
  s.frameworks = "Foundation", "CoreFoundation", "UIKit"
    
  # User
  s.author             = { "村雨灬龑" => "xyl_private@163.com" } # 作者信息

  s.pod_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
  s.user_target_xcconfig = { "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64" }
  
  
end
