//
//  DateExtension.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation

public extension Date {
  var weekDayString: String {
    guard let week = component(.weekday) else {
      return "星期天"
    }
    switch week {
    case 1:
      return "星期天"
    case 2:
      return "星期一"
    case 3:
      return "星期二"
    case 4:
      return "星期三"
    case 5:
      return "星期四"
    case 6:
      return "星期五"
    case 7:
      return "星期六"
    default:
      return "星期天"
    }
  }
}
