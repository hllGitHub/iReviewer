//
//  DBBaseObject.swift
//  iReviewer
//
//  Created by liangliang hu on 2020/9/15.
//  Copyright © 2020 com.liangliang. All rights reserved.
//

import Foundation
import RealmSwift

class DBBaseObject: Object {
  dynamic var note1: String?
  dynamic var note2: String?

  /// Add
  func add() {
    guard let realm = try? Realm() else {
      return
    }
    try? realm.write({
      realm.add(self)
    })
  }

  /// Delete
  func delete() {
    guard let realm = try? Realm() else {
      return
    }
    try? realm.write({
      realm.delete(self)
    })
  }

  /// Query
  static func query<T: Object>(_ type: T.Type, _ filterStr: String? = nil) -> Results<T>? {
    guard let realm = try? Realm() else {
      return nil
    }

    if let str = filterStr {
      return realm.objects(type).filter(str)
    } else {
      return realm.objects(type)
    }
  }

  /// Query in multiThreads
  static func query<T: Object>(_ type: T.Type, _ filterStr: String? = nil, block: @escaping ((_ results: Results<T>) -> Void)) {
    DispatchQueue(label: "background").async {
      guard let realm = try? Realm() else {
        return
      }

      if let str = filterStr {
        let objects = realm.objects(type).filter(str)
        block(objects)
      } else {
        let objects = realm.objects(type)
        block(objects)
      }
    }
  }

  /// Update
  static func update(_ block: (() throws -> Swift.Void)) {
    guard let realm = try? Realm() else {
      return
    }
    try? realm.write(block)
  }
}
