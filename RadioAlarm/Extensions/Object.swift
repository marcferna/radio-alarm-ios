//
//  Object.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/5/15.
//  Copyright © 2015 RadioAlarm. All rights reserved.
//

import RealmSwift

extension Object {
  
  func save(success success: (()->())?, failure: (()->())?) {
    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    dispatch_async(queue) {
      do {
        let realm = try Realm()
        realm.write {
          realm.add(self)
        }
        success?()
        return
      } catch _ { }
      failure?()
    }
  }
  
  func delete(success success: (()->())?, failure: (()->())?) {
    do {
      let realm = try Realm()
      realm.write {
        realm.delete(self)
      }
      success?()
    } catch {
      failure?()
    }
  }
}