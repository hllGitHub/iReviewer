//
//  LoggerConfiguration.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/9.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation
import CocoaLumberjack

public class LoggerConfiguration: AppConfigurationable {
  public func setup(user: User?) {
    DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
    let fileLogger: DDFileLogger = DDFileLogger() // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
  }
}
