//
//  UIViewExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIView {

  /// 部分圆角
  ///
  /// - Parameters:
  ///   - corners: 需要实现为圆角的角，可传入多个
  ///   - radii: 圆角半径
  func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
  }
}
