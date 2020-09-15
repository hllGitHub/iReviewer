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

class Event: DBBaseObject {
  var eventId: String?

  dynamic var name: String = ""

  dynamic var priority: EventPriority = .low // 事件优先级，暂定只有三类

  dynamic var createAt: TimeInterval = 0 // 创建日期

  dynamic var modifiedAt: TimeInterval = 0 // 最后一次修改日期
}
