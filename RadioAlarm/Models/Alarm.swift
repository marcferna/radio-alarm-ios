//
//  Alarm.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/3/15.
//  Copyright (c) 2015 RadioAlarm. All rights reserved.
//

import RealmSwift

class Alarm: Object {
  
  dynamic var name: String = ""
  dynamic var order: Int = 0
  dynamic var time: NSDate = NSDate(timeIntervalSince1970: 1)
  dynamic var enabled: Bool = false
}