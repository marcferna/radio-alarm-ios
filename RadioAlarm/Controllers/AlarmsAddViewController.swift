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
      let spinner = Spinner(view: self.view)
      let newAlarm = Alarm()
      newAlarm.name = self.nameTextField.text!
      newAlarm.time = self.timePicker.date
      newAlarm.save(success: {
        spinner.dismiss()
        self.dismissViewControllerAnimated(true, completion: nil)
      }, failure: {
        spinner.dismiss()
      })
    }
  }
  
  private func validateFields() -> Bool {
    return !self.nameTextField.text!.isEmpty
  }
}
