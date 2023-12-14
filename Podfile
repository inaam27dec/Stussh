# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StushApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'IQKeyboardManagerSwift'
  pod 'ReachabilitySwift'
  pod 'ARSLineProgress'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'SDWebImage'
  pod 'UIView-Shimmer', '~> 1.0'
  pod 'LGSideMenuController'
  pod 'MZFormSheetPresentationController'
  pod 'SwiftJWT'
  # Pods for StushApp
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = "13.0"
     end
  end
end
