//
//  AppDelegate.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Configu UI
    IReviewerAppearence.configUIBarButtonItemStyle()
    IReviewerAppearence.configUINavigationbarStyle()
    return true
  }

  // MARK: UISceneSession Lifecycle

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  @available(iOS 13.0, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}

class IReviewerAppearence {
  fileprivate static func configUINavigationbarStyle() {
    UINavigationBar.appearance().titleTextAttributes = [.font: UIFont.h3, .foregroundColor: UIColor.tint]
    UINavigationBar.appearance().barTintColor = .barBg
    UINavigationBar.appearance().isTranslucent = false

    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().backIndicatorImage = UIImage()
    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage()
  }

  fileprivate static func configUIBarButtonItemStyle() {
    UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.customYuantiBoldFont(ofSize: 16), .foregroundColor: UIColor.tint], for: .normal)
    UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.customYuantiBoldFont(ofSize: 16), .foregroundColor: UIColor.tint], for: .highlighted)
    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -300, vertical: 0), for: UIBarMetrics.default)

    let capInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -20)
    let backImage = R.image.back()?.resizableImage(withCapInsets: capInsets).withRenderingMode(.alwaysOriginal)
    UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImage, for: .normal, barMetrics: .default)
    UIViewController.swizzledViewDidLoad()
  }
}
