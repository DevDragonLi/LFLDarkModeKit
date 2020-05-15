Pod::Spec.new do |s|
  s.name             = 'LFLDarkModeKit'
  s.version          = '0.4.0'
  s.summary          = 'LFLDarkModeKit'
  s.description      = "iOS DarkMode Adapter Kit"
  s.homepage         = 'https://github.com/DevDragonli/LFLDarkModeKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DevDragonli' => 'DragonLi_52171@163.com' }
  s.source           = { :git => 'https://github.com/DevDragonli/LFLDarkModeKit.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '9.0'
  s.public_header_files = 'LFLDarkModeKit/Classes/LFLDarkModeKit.h'
  s.source_files = 'LFLDarkModeKit/Classes/LFLDarkModeKit.h'
  s.subspec 'core' do |ss|
    ss.source_files = 'LFLDarkModeKit/Classes/Core/*'
    ss.public_header_files = 'LFLDarkModeKit/Classes/core/**.h'
    ss.dependency 'LFLDarkModeKit/Tool'
  end
  s.subspec 'Tool' do |ss|
    ss.source_files = 'LFLDarkModeKit/Classes/Tool/*'
    ss.public_header_files = 'LFLDarkModeKit/Classes/Tool/LFLDarkModeTool.h'
  end
  
  
end
