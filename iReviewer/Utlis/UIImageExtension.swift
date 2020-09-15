//
//  UIImageExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIImage {
  class func image(color: UIColor, size: CGSize, cornerRadius: CGFloat = 0.0) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { (_) in
      color.setFill()
      let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: cornerRadius)
      path.fill()
    }
  }

  func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(
      CGSize(width: size.width + insets.left + insets.right,
             height: size.height + insets.top + insets.bottom),
      false,
      self.scale)

    let origin = CGPoint(x: insets.left, y: insets.top)
    self.draw(at: origin)
    let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return imageWithInsets
  }
}

public extension UIImage {
  func withRoundCorner(radius: CGFloat, size: CGSize) -> UIImage? {
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    //开始图形上下文
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    guard let context = UIGraphicsGetCurrentContext() else {
      return nil
    }

    //绘制路线
    context.addPath(UIBezierPath(roundedRect: rect,
                                 byRoundingCorners: UIRectCorner.allCorners,
                                 cornerRadii: CGSize(width: radius, height: radius)).cgPath)
    //裁剪
    context.clip()
    //将原图片画到图形上下文
    self.draw(in: rect)
    context.drawPath(using: .fillStroke)
    let output = UIGraphicsGetImageFromCurrentImageContext()
    //关闭上下文
    UIGraphicsEndImageContext()
    return output
  }

  func cropImage(size: CGSize) -> UIImage? {
    let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width * self.scale, height: size.height * self.scale))

    guard let cutImageRef: CGImage = self.cgImage?.cropping(to: rect) else {
      return nil
    }

    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
  }

  func cropImage(rect: CGRect) -> UIImage? {
    guard let cutImageRef: CGImage = self.cgImage?.cropping(to: rect) else {
      return nil
    }

    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
  }

}

public extension UIImage{
  /// Set image color
  func imageWithTintColor(color: UIColor) -> UIImage?{
    UIGraphicsBeginImageContext(self.size)
    color.setFill()
    let bounds = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
    UIRectFill(bounds)
    self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)

    let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return tintedImage
  }
}
