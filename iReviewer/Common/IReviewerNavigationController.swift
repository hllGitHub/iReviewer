//
//  IReviewerNavigationController.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public class IReviewerNavigationController: UINavigationController {
  private var isPushing = false

  public var willShowCallback: (() -> Void)?

  override public func viewDidLoad() {
    super.viewDidLoad()

    delegate = self
    view.backgroundColor = UIColor.white
  }

  override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
    guard isPushing == false else {
      return
    }

    isPushing = true
    super.pushViewController(viewController, animated: animated)
  }

  override public var shouldAutorotate: Bool {
    // Lock autorotate
    return true
  }

  override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return self.topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }

  public override var preferredStatusBarStyle: UIStatusBarStyle {
    return self.topViewController?.preferredStatusBarStyle ?? .default
  }

  public override var childForStatusBarStyle: UIViewController? {
    return self.topViewController
  }
}

extension IReviewerNavigationController: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    self.isPushing = false
  }
  
  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    willShowCallback?()
  }
}
