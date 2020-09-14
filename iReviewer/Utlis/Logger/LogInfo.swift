//
//  LogInfo.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/14.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation

public struct LogInfo {
  public let level: LogLevel
  public let filename: String
  public let funcname: String
  public let line: Int
  public let timeval: timeval
  public let tname: String
  public let tag: String?

  init(level: LogLevel, filename: String, funcname: String, line: Int, timeval: timeval, tname: String, tag: String?) {
    self.level = level
    self.filename = filename
    self.funcname = funcname
    self.line = line
    self.timeval = timeval
    self.tname = tname
    self.tag = tag
  }

//  [Debug][2020-9-14 18:57:0.121][105553157650752][Tachikoma.Tracking][LLSTachikomaConfiguration, setup(user:), 40] Tachikoma upload events finished!
  func logMeta() -> String {
    var metaPrefix = "Debug"
    switch level {
    case .debug:
      metaPrefix = "Debug"
    case .error:
      metaPrefix = "Error"
    case .info:
      metaPrefix = "Info"
    case .verbose:
      metaPrefix = "Verbose"
    case .warning:
      metaPrefix = "Warning"
    }

    let t = Double(timeval.tv_sec) + Double(timeval.tv_usec) / Double(USEC_PER_SEC)
    let meta = "[\(metaPrefix)]" + "[\(t)]" + "[\(tname)]" + "[\(filename)]" + "[\(funcname), \(line)]"
    return meta
  }
}
