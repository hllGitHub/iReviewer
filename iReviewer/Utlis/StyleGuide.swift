//
//  StyleGuide.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public extension UIColor {
  /// #2A83E9
  @nonobjc class var tint: UIColor {
    return UIColor(r: 42, g: 131, b: 233)
  }

  /// #A6A2A1
  @nonobjc class var iGray: UIColor {
    return UIColor(r: 166, g: 152, b: 161)
  }

  /// #202B43
  @nonobjc class var dft: UIColor {
    return UIColor(r: 32, g: 43, b: 67)
  }

  /// #788295
  @nonobjc class var sub: UIColor {
    return UIColor(r: 120, g: 130, b: 149)
  }

  @nonobjc class var fff: UIColor {
    return UIColor(white: 1.0, alpha: 1.0)
  }

  @nonobjc class var weakButton: UIColor {
    return UIColor(r: 241, g: 243, b: 249)
  }

  @nonobjc class var hl: UIColor {
    return UIColor(r: 245, g: 166, b: 35)
  }

  /// #F5F7F8
  @nonobjc class var grayBg: UIColor {
    return UIColor(r: 245, g: 247, b: 248)
  }

  @nonobjc class var steel: UIColor {
    return UIColor(r: 120, g: 130, b: 149)
  }

  @nonobjc class var offWhite: UIColor {
    return UIColor(r: 255, g: 243, b: 226)
  }

  @nonobjc class var disable: UIColor {
    return UIColor(r: 221, g: 221, b: 221)
  }

  @nonobjc class var paleYellow: UIColor {
    return UIColor(r: 255, g: 244, b: 225, a: 1.0)
  }

  @nonobjc class var line: UIColor {
    return UIColor(r: 239, g: 241, b: 244, a: 1)
  }

  /// #F2F4FA
  @nonobjc class var lightGrey: UIColor {
    return UIColor(r: 242, g: 244, b: 250)
  }

  @nonobjc class var yel: UIColor {
    return UIColor(r: 255, g: 167, b: 0)
  }
}

public extension UIColor {
  @nonobjc class var separator: UIColor {
    return UIColor(r: 242, g: 244, b: 250)
  }
}

public extension UIColor {
  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
    self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
  }

  convenience init(hexString: String) {
    //处理数值
    var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

    let length = (cString as NSString).length
    //错误处理
    if length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7) {
      //返回whiteColor
      self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
      return
    }

    if cString.hasPrefix("#") {
      cString = (cString as NSString).substring(from: 1)
    }

    //字符串截取
    var range = NSRange()
    range.location = 0
    range.length = 2

    let rString = (cString as NSString).substring(with: range)

    range.location = 2
    let gString = (cString as NSString).substring(with: range)

    range.location = 4
    let bString = (cString as NSString).substring(with: range)

    //存储转换后的数值
    var r: UInt32 = 0, g: UInt32 = 0, b: UInt32 = 0
    //进行转换
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    //根据颜色值创建UIColor
    self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
  }

  static var random: UIColor {
    return UIColor(red: .random(in: 0...1),
                   green: .random(in: 0...1),
                   blue: .random(in: 0...1),
                   alpha: 1.0)
  }
}

// Text styles

public extension UIFont {

  /// Size: 30.0
  class var h1: UIFont {
    return UIFont(name: "HuaWenYuanTi-Bold", size: 30.0) ?? UIFont.systemFont(ofSize: 30.0)
  }

  /// Size: 24.0
  class var h2: UIFont {
    return UIFont(name: "HuaWenYuanTi-Bold", size: 24.0) ?? UIFont.systemFont(ofSize: 24.0)
  }

  /// Size: 20.0
  class var h3: UIFont {
    return UIFont(name: "HuaWenYuanTi-Bold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
  }

  /// Size: 50.0
  class var h4: UIFont {
    return UIFont(name: "HuaWenYuanTi-Bold", size: 50.0) ?? UIFont.systemFont(ofSize: 50.0)
  }

  /// Size: 20.0
  class var body1: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
  }

  /// Size: 16.0
  class var body2: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
  }

  /// Size: 12.0
  class var body3: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0)
  }

  /// Size: 28.0
  class var body4: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 28.0) ?? UIFont.systemFont(ofSize: 28.0)
  }

  /// Size: 14.0
  class var tip1: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
  }
}

public extension UIFont {

  class var pf_h2: UIFont {
    return UIFont(name: "PingFangSC-Semibold", size: 24.0) ?? UIFont.systemFont(ofSize: 24.0)
  }

  class var pf_h3: UIFont {
    return UIFont(name: "PingFangSC-Semibold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0)
  }


  class var pf_body2: UIFont {
    return UIFont(name: "PingFangSC-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0)
  }

  class var pf_tip1: UIFont {
    return UIFont(name: "PingFangSC-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
  }

}
public extension UIFont {
  /// Size: 18.0
  class var tip2: UIFont {
    return UIFont(name: "HuaWenYuanTi-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 18.0)
  }
}

