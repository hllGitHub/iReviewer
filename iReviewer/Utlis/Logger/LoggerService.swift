//
//  LoggerService.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/14.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation
import CocoaLumberjack

class LoggerService: NSObject {
  static let shared = LoggerService()

  func configCrashCapture(open: Bool, crashTag: String) {

  }

  func dispatchSend(level: LogLevel, message: @escaping @autoclosure () -> Any, tag: String?, file: String, function: String, line: Int, asynchronously: Bool? = nil) {
    let log = "\(message())"
    var time: timeval = Darwin.timeval()
    gettimeofday(&time, nil)

    let tname = Thread.current.threadName
    let logInfo = LogInfo(level: level, filename: LoggerService.fileNameWithoutSuffix(file), funcname: function, line: line, timeval: time, tname: tname, tag: tag)

    switch level {
    case .debug:
      DDLogDebug(logInfo.logMeta() + " " + log)
    case .error:
      DDLogError(logInfo.logMeta() + " " + log)
    case .info:
      DDLogInfo(logInfo.logMeta() + " " + log)
    case .verbose:
      DDLogVerbose(logInfo.logMeta() + " " + log)
    case .warning:
      DDLogWarn(logInfo.logMeta() + " " + log)
    }
  }

  /// returns the filename of a path
  class func fileNameOfFile(_ file: String) -> String {
    let fileParts = file.components(separatedBy: "/")
    if let lastPart = fileParts.last {
      return lastPart
    }
    return ""
  }

  /// returns the filename without suffix (= file ending) of a path
  class func fileNameWithoutSuffix(_ file: String) -> String {
    let fileName = fileNameOfFile(file)

    if !fileName.isEmpty {
      let fileNameParts = fileName.components(separatedBy: ".")
      if let firstPart = fileNameParts.first {
        return firstPart
      }
    }
    return ""
  }
}

extension Thread {
  var threadName: String {
    if Thread.isMainThread {
      return "Main"
    }
    let name = __dispatch_queue_get_label(nil)
    return String(cString: name, encoding: .utf8) ?? Thread.current.description
  }
}
