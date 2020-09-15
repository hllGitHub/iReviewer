//
//  UIApplicationExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIApplication {
  static var appName: String {
    guard let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String else {
      return "unknown"
    }
    return appName

  }

  static var appVersion: String {
    guard let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
      return "unknown"
    }
    return appVersion
  }

  static var appBuildVersion: String {
    guard let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
      return "unknown"
    }
    return buildVersion
  }
}

public extension UIApplication {
  var statusHeight: CGFloat {
    if #available(iOS 13.0, *) {
      return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
      return UIApplication.shared.statusBarFrame.height
    }
  }
}
