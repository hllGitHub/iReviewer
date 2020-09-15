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

extension UIViewController {
  private var topPresentedViewController: UIViewController? {
    guard var topOfStack = UIApplication.shared.delegate?.window??.rootViewController else { return nil }
    while let presentedViewController = topOfStack.presentedViewController {
      topOfStack = presentedViewController
    }
    return topOfStack
  }

  public static func findBottomPresentedViewController<T: UIViewController>() -> T? {
    guard var vc = UIApplication.shared.delegate?.window??.rootViewController else { return nil }
    while let presentedViewController = vc.presentedViewController {
      if let ret = presentedViewController as? T {
        return ret
      }
      vc = presentedViewController
    }
    return nil
  }

  public func show(animated: Bool = true) {
    topPresentedViewController?.present(self, animated: animated, completion: nil)
  }
}

public extension UIViewController {
  var isModal: Bool {
    return presentingViewController != nil
  }
}

public extension UINavigationBar {
  func setTranslucent(_ translucent: Bool) {
    if translucent {
      isTranslucent = true
      setBackgroundImage(UIImage(), for: .default)
      shadowImage = UIImage()
    } else {
      isTranslucent = false
      setBackgroundImage(nil, for: .default)
      shadowImage = nil
    }
  }

  func changeStyle(color: UIColor, offsetY: CGFloat, distance: CGFloat = UIApplication.shared.statusHeight + 64) {
    if offsetY <= 0 {
      isHidden = true
    } else {
      isHidden = false
      let alpha = offsetY / distance > 1.0 ? 1.0 : (offsetY / distance)
      let image = UIImage.image(color: color.withAlphaComponent(alpha), size: frame.size)
      setBackgroundImage(image, for: .default)
    }
  }
}

public extension UINavigationItem {
  func changeStyle(offsetY: CGFloat, distance: CGFloat = UIApplication.shared.statusHeight + 64) {
    let alpha = offsetY / distance > 1.0 ? 1.0 : (offsetY / distance)

    guard let label = titleView as? UILabel else {
      return
    }

    label.alpha = alpha
  }
}

public extension UIViewController {
  /// 从当前控制器栈里面移除
  func removeFromNavigationController() {
    guard let viewControllers = navigationController?.viewControllers, viewControllers.count > 1 else {
      return
    }
    navigationController?.viewControllers = viewControllers.filter({$0 != self})
  }
}
