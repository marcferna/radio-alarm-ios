//
//  AlarmsTableViewController.swift
//  RadioAlarm
//
//  Created by Marc Fernandez on 7/3/15.
//  Copyright (c) 2015 RadioAlarm. All rights reserved.
//

import UIKit
import RealmSwift

class AlarmsTableViewController: UITableViewController {
  
  private var alarms: Results<Alarm>!
  private var notificationToken: NotificationToken?
  private var alarmTimeFormatter = NSDateFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTable()
    setupNavigation()
    setupFormatter()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func setupNavigation() {
    self.title = "Alarms"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editWasTapped")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWasTapped")
  }
  
  private func setupTable() {
    tableView.estimatedRowHeight = 69
    tableView.registerNib(
      UINib(nibName: "AlarmTableViewCell", bundle: nil),
      forCellReuseIdentifier: AlarmTableViewCell.identifier
    )
    
    do {
      alarms = try Realm().objects(Alarm).sorted("order")
      try notificationToken = Realm().addNotificationBlock { [unowned self] note, realm in
        self.tableView.reloadData()
      }
    } catch _ {
      alarms = Results<Alarm>.new()
      tableView.reloadData()
    }
  }
  
  private func setupFormatter() {
    alarmTimeFormatter.dateFormat = "HH:mm a"
  }
}

// MARK: - Table view data source

extension AlarmsTableViewController {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alarms.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(AlarmTableViewCell.identifier, forIndexPath: indexPath) as! AlarmTableViewCell
    
    let alarm = alarms[indexPath.row]
    cell.titleLabel.text = alarm.name
    cell.timeLabel.text = alarmTimeFormatter.stringFromDate(alarm.time)
    
    return cell
  }
}

// MARK: - Navigation items target actions

extension AlarmsTableViewController {
  
  internal func editWasTapped() {
    
  }
  
  internal func addWasTapped() {
    let alarmsAddNavigation = AlarmsAddNavigationController(
      rootViewController: AlarmsAddViewController()
    )
    self.presentViewController(alarmsAddNavigation, animated: true, completion: nil)
  }
}
