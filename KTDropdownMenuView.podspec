Pod::Spec.new do |s|
    s.name         = 'KTDropdownMenuView'
    s.version      = '1.0.0'
    s.summary      = 'A Dropdown Menu Navigation View'
    s.homepage     = 'https://github.com/tujinqiu/KTDropdownMenuView'
    s.license      = 'MIT'
    s.authors      = {'tujinqiu' => 'tujinqiu@126.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/tujinqiu/KTDropdownMenuView.git', :tag => s.version}
    s.source_files = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/**/*.{h,m}'
    s.resource     = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/KTDropdownMenuView.bundle'
    s.dependency     ‘Masonry’, '~> 0.6.3’
    s.requires_arc = true
end
