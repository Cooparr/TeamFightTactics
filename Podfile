# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'TeamFightTactics' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TeamFightTactics
	pod 'SDWebImage'
	pod 'Firebase/Analytics'
	pod 'Firebase/Core'
	pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'
	pod 'Protobuf', :inhibit_warnings => true

  target 'TFT_CompanionTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TFT_CompanionUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
