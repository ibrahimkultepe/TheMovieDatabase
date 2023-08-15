# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

workspace 'TheMovieDatabase'

# Network
$Alamofire =  pod 'Alamofire', '~> 5.4'

# Helper
$TinyConstraints = pod "TinyConstraints", '~> 4.0'
$IQKeyboardManagerSwift = pod "IQKeyboardManagerSwift", '~> 6.5'
$SwiftLint = pod 'SwiftLint', '~> 0.44'
$MobilliumUserDefaults = pod 'MobilliumUserDefaults', '~> 2.0'
$MobilliumDateFormatter = pod 'MobilliumDateFormatter', '~> 1.2'
$MobilliumBuilders = pod 'MobilliumBuilders', '~> 1.4'
$Segmentio = pod 'Segmentio', '~> 4.1'
$Kingfisher = pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :branch => 'version6-xcode13'
$SwiftEntryKit = pod 'SwiftEntryKit', '~> 1.2'
$SKPhotoBrowser = pod 'SKPhotoBrowser', '~> 7.0'
$KeychainSwift = pod 'KeychainSwift', '~> 19.0'
$SwiftGen = pod 'SwiftGen', '~> 6.5'

target 'TheMovieDatabase' do
  
  project 'TheMovieDatabase.xcodeproj'

  # Pods for TheMovieDatabase
  
  # Network
  $Alamofire
  
  # Helper
  $TinyConstraints
  $IQKeyboardManagerSwift
  $SwiftLint
  $MobilliumUserDefaults
  $MobilliumDateFormatter
  $MobilliumBuilders
  $Segmentio
  $Kingfisher
  $SwiftEntryKit
  $SKPhotoBrowser
  $KeychainSwift
end

target 'DataProvider' do
  
  project 'DataProvider/DataProvider.xcodeproj'
  
  # Pods for DataProvider

end

target 'UIComponents' do
  
  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  
  # Helper
  $TinyConstraints
  $SwiftGen
  $MobilliumBuilders
  $Segmentio
  $Kingfisher
  $SwiftEntryKit
  
end

target 'Utilities' do
  
  project 'Utilities/Utilities.xcodeproj'
  
  # Pods for Utilities
  
  # Helper
  $MobilliumUserDefaults
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
