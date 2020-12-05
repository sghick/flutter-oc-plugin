Pod::Spec.new do |s|
    s.name         = 'SMRFlutterPlugins'
    s.version      = '1.0.0'
    s.summary      = 'the flutter for oc plugin'
    s.authors      = { 'tinswin' => ''}
    s.homepage     = 'https://github.com/sghick/flutter-oc-plugin'
    s.platform     = :ios
    s.ios.deployment_target = '9.0'
    s.requires_arc = true
    s.source       = { :git => 'git@github.com:sghick/flutter-oc-plugin.git' }

    s.subspec 'SMRFlutterPlugins' do |ss| 
        ss.source_files = 'SMRFlutterPlugins/*.{h,m,c,mm}'
    end

    s.dependency 'Flutter'
    
end
