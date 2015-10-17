Pod::Spec.new do |s|
    s.name         = 'MJRefresh'
    s.version      = ‘1.0.0’
    s.summary      = ‘A Dropdown Menu Navigation View with Objective-C’
    s.homepage     = 'https://github.com/tujinqiu/KTDropdownMenuView'
    s.license      = 'MIT'
    s.authors      = {‘tujinqiu’ => ‘tujinqiu2008@126.com'}
    s.platform     = :ios, ‘7.0’
    s.source       = {:git => 'https://github.com/tujinqiu/KTDropdownMenuView.git', :tag => s.version}
    s.source_files = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/**/*.{h,m}'
    s.resource     = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/KTDropdownMenuView.bundle'
    s.requires_arc = true
end