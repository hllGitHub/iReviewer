platform :ios, '10.0'
workspace 'iReviewer.xcworkspace'
source "https://cdn.cocoapods.org"

use_frameworks!

def pod_base_module()
  pod 'RxSwift', '5.0.1'
  pod 'RxCocoa', '5.0.1'
  pod 'RxBlocking', '5.0.1'
  pod 'Differentiator', '4.0.1'
  pod 'RxDataSources', '4.0.1'
  pod 'SVProgressHUD', '2.2.5'
  pod 'PureLayout', '3.1.4'
  pod 'R.swift'
  pod 'FSPagerView', '0.8.3'
  pod 'IGListKit', '4.0.0'
  pod 'SDWebImage', '5.1.1'
  pod 'CocoaLumberjack/Swift'
end

def pod_business_module()
  pod 'JTCalendar', '~> 2.2.6'
  pod 'AFDateHelper', '~> 4.3.0'
  pod 'RealmSwift'
end

target 'iReviewer'  do
  pod_base_module()
  pod_business_module()
end
