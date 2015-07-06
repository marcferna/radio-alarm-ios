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
  
  private var alarms: [Alarm]!
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
      let realm = try Realm()
      self.alarms = Array(realm.objects(Alarm).sorted("order").generate()) as [Alarm]
      notificationToken = realm.addNotificationBlock { [unowned self] note, realm in
        self.alarms = Array(realm.objects(Alarm).sorted("order").generate()) as [Alarm]
        self.tableView.reloadData()
      }
    } catch _ {
      alarms = [Alarm]()
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
    cell.showsReorderControl = true
    return cell
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    let spinner = Spinner(view: self.view)
    let alarm = alarms[indexPath.row]
    alarm.delete(
      success: { spinner.dismiss() },
      failure: { spinner.dismiss() }
    )
  }
  
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
    let alarm = alarms.removeAtIndex(sourceIndexPath.row)
    alarms.insert(alarm, atIndex: destinationIndexPath.row)
    
    let startIndex = min(sourceIndexPath.row, destinationIndexPath.row)
    let endIndex = max(sourceIndexPath.row, destinationIndexPath.row)
    for index in startIndex...endIndex {
      let alarm = alarms[index]
      print("\(alarm.name) should have order \(index)")
    }
  }
}

// MARK: - Navigation items target actions

extension AlarmsTableViewController {
  
  internal func editWasTapped() {
    tableView.setEditing(!tableView.editing, animated: true)
  }
  
  internal func addWasTapped() {
    tableView.setEditing(false, animated: true)
    let alarmsAddNavigation = AlarmsAddNavigationController(
      rootViewController: AlarmsAddViewController()
    )
    self.presentViewController(alarmsAddNavigation, animated: true, completion: nil)
  }
}
