# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
  end

# Add the Firebase pod for Google Analytics
pod 'Firebase/Analytics'

# Add the pods for any other Firebase products you want to use in your app
# For example, to use Firebase Authentication and Cloud Firestore
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'

target 'Figos' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Figos

  target 'FigosTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FigosUITests' do
    # Pods for testing
  end

end
