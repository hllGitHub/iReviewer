//
//  ModuleContext.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation

public struct ModuleContext {
  /// 工程当前所处环境的定义
  ///
  /// - feature: 开发环境
  /// - stage: 模拟测试环境
  /// - test: 线上测试环境
  /// -
  public enum Environment {
    case feature
    case stage
    case test
    case prod
  }

  /// 当前项目的初始环境信息
  public let environment: Environment

  public let customContext: Any?

  /// 当前项目 URL Route 所使用的的 scheme
  public let scheme: String

  public init(
    scheme: String = "IReviewer",
    environment: Environment = .prod,
    customContext: Any? = nil
  ) {
    self.scheme = scheme
    self.environment = environment
    self.customContext = customContext
  }
}
