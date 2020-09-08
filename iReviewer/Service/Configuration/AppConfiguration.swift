//
//  AppConfiguration.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/7.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation

/// ***
/// 使用 `AppConfiguration.shared` 对当前的 Host App 进行配置。
///

public class AppConfiguration {
  public static let shared = AppConfiguration()

  public private(set) var configurations = [AppConfigurationable]()
  public private(set) var environment: ModuleContext.Environment = .prod

  public func registerConfiguration(configurations: [AppConfigurationable], environment: ModuleContext.Environment = .prod) {
    self.environment = environment

    self.configurations = configurations.sorted { $0.priority > $1.priority }
    let user = User()
    self.configurations.forEach { (configuration) in
      configuration.setup(user: user)
    }
  }

  private init() {}
}

extension AppConfiguration: UserLifecycleService {
  func userWillLogin(user: User) {
    configurations.forEach { $0.userWillLogin(user: user) }
  }

  func userDidLogin(user: User) {
    configurations.forEach { $0.userDidLogin(user: user) }
  }

  func userWillLogout(user: User) {
    configurations.forEach { $0.userWillLogout(user: user) }
  }

  func userDidLogout(user: User) {
    configurations.forEach { $0.userDidLogout(user: user) }
  }
}

extension AppConfiguration {
  public enum APIEnvironment: Int {
    case feature
    case develop
    case staging
    case production
  }

  static public var apiEnv: APIEnvironment {
    switch AppConfiguration.shared.environment {
    case .feature:
      return APIEnvironment.feature
    case .stage:
      return APIEnvironment.develop
    case .test:
      return APIEnvironment.staging
    case .prod:
      return APIEnvironment.production
    }
  }
}
