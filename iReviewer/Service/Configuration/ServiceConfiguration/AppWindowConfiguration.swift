//
//  AppWindowConfiguration.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/9.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation
import UIKit

public class AppWindowConfiguration: AppConfigurationable {
  public func setup(user: User?) {
    // Configu UI
    IReviewerAppearence.config()
  }
}

class IReviewerAppearence {
  static func config() {
    configUIBarButtonItemStyle()
    configUINavigationbarStyle()
  }

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
