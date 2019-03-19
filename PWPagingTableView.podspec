
Pod::Spec.new do |s|


  s.name         = "PWPagingTableView"
  s.version      = "0.0.6"
  s.summary      = "tableview的分割管理"


  s.description  = "tableview的分割管理"

  s.homepage     = "https://github.com/wnrz/PWPagingTableView.git"

  s.license      = "MIT"

  s.author       = { "PW" => "66682060@qq.com" }


  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.public_header_files = 'PWPagingTableView/**/*.h'
  s.source_files = 'PWPagingTableView/**/*{h,m}'

  s.source = { :git => 'https://github.com/wnrz/PWPagingTableView.git', :tag => s.version.to_s}
  

  s.requires_arc = true
  s.framework = "UIKit","Foundation"


  s.subspec 'PWPagingTableView' do |ss|#
    ss.source_files = 'PWPagingTableView/PWPagingTableView/**/*.{h,m,c}'
    ss.ios.frameworks = 'UIKit', 'Foundation','UIKit'
  end

  s.resource_bundles = {'PWPagingTableView' => ['PWPagingTableView/PWPagingTableView/**/*.{png,plist,xib}']}


  s.dependency 'PWDataBridge'
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
end
