//
//  AlarmsAddViewController.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/4/15.
//  Copyright © 2015 RadioAlarm. All rights reserved.
//

import UIKit
import RealmSwift

class AlarmsAddViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var timePicker: UIDatePicker!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    timePicker.datePickerMode = .Time
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func setupNavigation() {
    self.title = "Add Alarm"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelWasTapped")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveWasTapped")
  }
}

extension AlarmsAddViewController {
  internal func cancelWasTapped() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  internal func saveWasTapped() {
    // Start spinner
    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    dispatch_async(queue) {
      do {
        let realm = try Realm()
        realm.beginWrite()
        realm.create(Alarm.self, value: ["name": "randomString", "time": NSDate()])
        realm.commitWrite()
      } catch _ {
        // Error the element couldn't get save
      }
      self.dismissViewControllerAnimated(true, completion: nil)
      // End Spinner
    }
  }
}
