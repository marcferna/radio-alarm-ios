//
//  AlarmTableViewCell.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/4/15.
//  Copyright © 2015 RadioAlarm. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
  
  static let identifier = "alarmCell"
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var enableSwitch: UISwitch!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
