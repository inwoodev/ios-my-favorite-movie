# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def for_test
  pod 'Quick'
  pod 'Nimble'
end 

target 'ios-my-favorite-movie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ios-my-favorite-movie
  pod 'SwiftLint'
  
  target 'ios-my-favorite-movieTests' do
    inherit! :search_paths
    for_test
  end
end
