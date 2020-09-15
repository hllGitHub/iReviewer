//
//  RealmConfiguration.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmConfiguration: AppConfigurationable {
  public func setup(user: User?) {
    setDefaultRealmForUser(user: user)
  }

  func setDefaultRealmForUser(user: User?) {
    guard let user = user else {
      return
    }

    var config = Realm.Configuration()

    guard let fileURL = config.fileURL else {
      return
    }

    // 使用默认的目录，但是请将文件名替换为用户名
    config.fileURL = fileURL.deletingLastPathComponent().appendingPathComponent("\(user.userId).realm")

    // 将该配置设置为默认 Realm 配置
    Realm.Configuration.defaultConfiguration = config

    print(config.fileURL)
  }
}
