//
//  Spinner.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/5/15.
//  Copyright © 2015 RadioAlarm. All rights reserved.
//

import JGProgressHUD

class Spinner {
  
  private var spinner: JGProgressHUD!
  
  init(view: UIView) {
    spinner = JGProgressHUD(style: .Dark)
    spinner.showInView(view, animated: true)
  }
  
  func dismiss() {
    spinner.dismissAnimated(true)
  }
}