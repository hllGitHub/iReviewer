//
//  Event.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/14.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import UIKit

public enum EventPriority: Int, Codable {
  case low = 100
  case medium = 200
  case high = 300
}

struct Event: Codable {
  var eventId: String

  var name: String

  var priority: EventPriority // 事件优先级，暂定只有三类

  var createAt: String // 创建日期

  var modifiedAt: String // 最后一次修改日期
}
