//
//  User.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation

public struct User: Codable {
  public var name: String

  public var userId: String

  static var defaultUser: User {
    return User(name: "Test", userId: "1")
  }
}

protocol UserLifecycleService: class {
  /// 用户登录操作成功，通过 Backend 拿到了 User Raw Data 时会调用
  ///
  /// - Parameter user: 当前用户信息
  func userWillLogin(user: User)

  /// 用户完成登录，用户信息已存入数据库
  ///
  /// - Parameter user: 当前用户信息
  func userDidLogin(user: User)

  /// 用户主动点击登出，将要发送登出网络请求前调用。
  ///
  /// - Parameter user: 当前用户信息
  func userWillLogout(user: User)

  /// 用户登出完成，数据已经被清理完时调用
  ///
  /// - Parameter user: 当前用户信息
  func userDidLogout(user: User)
}
