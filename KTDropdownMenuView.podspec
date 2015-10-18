Pod::Spec.new do |spec|
  spec.name         = 'KTDropdownMenuView'
  spec.version      = '1.0.0'
  spec.license      = 'MIT'
  spec.summary      = 'A Dropdown Menu Navigation View'
  spec.homepage     = 'https://github.com/tujinqiu/KTDropdownMenuView'
  spec.description = <<-DESC
                     A Dropdown Menu Navigation View withObjective-C
                   DESC
  spec.author       = 'tujinqiu'
  spec.source       = { :git => 'git://github.com/lukeredpath/libPusher.git', :tag => 'v1.3' }
  spec.source_files = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/**/*.{h,m}'
  spec.requires_arc = true
  spec.resource     = 'KTDropdownMenuViewDemo/KTDropdownMenuViewDemo/KTDropdownMenuView/KTDropdownMenuView.bundle'
  spec.dependency 'Masonry'
end
