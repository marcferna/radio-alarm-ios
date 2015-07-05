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
    if (validateFields()) {
      // Start spinner
      let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
      dispatch_async(queue) {
        do {
          let realm = try Realm()
          let newAlarm = Alarm()
          newAlarm.name = self.nameTextField.text!
          newAlarm.time = self.timePicker.date
          realm.write {
            realm.add(newAlarm)
          }
        } catch _ {
          // Error the element couldn't get save
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        // End Spinner
      }
    }
  }
  
  private func validateFields() -> Bool {
    return !self.nameTextField.text!.isEmpty
  }
}
