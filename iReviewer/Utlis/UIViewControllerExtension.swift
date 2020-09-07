//
//  UIViewControllerExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIViewController {
  @objc private dynamic func ga_viewDidLoad() {
    let backBarButtonItem = UIBarButtonItem.init(title: " ", style: .plain, target: nil, action: nil)
    self.navigationItem.backBarButtonItem = backBarButtonItem
    self.ga_viewDidLoad()
  }

  class func swizzledViewDidLoad() {
    let originalSel = #selector(UIViewController.viewDidLoad)
    let swizzledSel = #selector(UIViewController.ga_viewDidLoad)

    let originalMethod = class_getInstanceMethod(self, originalSel)
    let swizzledMethod = class_getInstanceMethod(self, swizzledSel)

    guard let newOriginalMethod = originalMethod, let newSwizzledMethod = swizzledMethod else {
      return
    }

    let isAdd = class_addMethod(self, originalSel, method_getImplementation(newSwizzledMethod), method_getTypeEncoding(newSwizzledMethod))
    if isAdd {
      class_replaceMethod(self, swizzledSel, method_getImplementation(newOriginalMethod), method_getTypeEncoding(newOriginalMethod))
    } else {
      method_exchangeImplementations(newOriginalMethod, newSwizzledMethod)
    }
  }
}
