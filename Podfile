# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'TeamFightTactics' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks! :linkage => :static
  use_frameworks!
  
  # Pods for TeamFightTactics
  pod 'SDWebImage'
  # pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift', '8.3.0-beta'
  pod 'Protobuf', :inhibit_warnings => true
  
  target 'TFT_CompanionTests' do
    inherit! :search_paths
    # Pods for testing
  end
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
