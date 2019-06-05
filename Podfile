# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ScreenFree' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  $awsVersion = '~> 2.9.0'
  pod 'AWSCore', $awsVersion
  pod 'AWSMobileClient', $awsVersion
  pod 'AWSAuthUI', $awsVersion
  pod 'AWSUserPoolsSignIn', $awsVersion
  pod 'AWSCognitoIdentityProvider', $awsVersion
  pod 'AWSPinpoint', $awsVersion

  # Pods for ScreenFree

  target 'ScreenFreeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ScreenFreeUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
