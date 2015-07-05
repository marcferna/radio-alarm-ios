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
  
  var alarms: Results<Alarm>!
  var notificationToken: NotificationToken?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTable()
    setupNavigation()
  }
  
  private func setupNavigation() {
    self.title = "Alarms"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editWasTapped")
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWasTapped")
  }
  
  private func setupTable() {
    do {
      alarms = try Realm().objects(Alarm).sorted("order")
      try notificationToken = Realm().addNotificationBlock { [unowned self] note, realm in
        self.tableView.reloadData()
      }
    } catch _ {
      alarms = Results<Alarm>.new()
      tableView.reloadData()
    }
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Table view data source

extension AlarmsTableViewController {
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return alarms.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
    
    let alarm = alarms[indexPath.row]
    cell.textLabel?.text = alarm.name
    cell.detailTextLabel?.text = alarm.time.description
    
    return cell
  }
}

// MARK: - Navigation items target actions

extension AlarmsTableViewController {
  
  internal func editWasTapped() {
    
  }
  
  internal func addWasTapped() {
//    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
//    // Import many items in a background thread
//    dispatch_async(queue) {
//      // Get new realm and table since we are in a new thread
//      do {
//        let realm = try Realm()
//        realm.beginWrite()
//        for _ in 0..<5 {
//          // Add row via dictionary. Order is ignored.
//          realm.create(Alarm.self, value: ["name": "randomString", "time": NSDate()])
//        }
//        realm.commitWrite()
//      } catch _ {
//        
//      }
//    }
  }
}
