# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

inhibit_all_warnings!

target 'BeyondSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for BeyondSwift
    pod 'RxSwift', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'develop'
    pod 'RxCocoa', :git => 'https://github.com/ReactiveX/RxSwift.git', :branch => 'develop'
    pod 'RxDataSources', '~> 3.0'
    pod 'ObjectMapper'
    pod 'Alamofire', '~> 4.7'
    pod 'SwiftLint'
    pod 'Swinject'
    pod 'SwinjectStoryboard'
    
    def testing_pods
        pod 'Quick'
        pod 'Nimble'
    end
    
  target 'BeyondSwiftTests' do
      inherit! :search_paths
    testing_pods
  end

  target 'BeyondSwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
