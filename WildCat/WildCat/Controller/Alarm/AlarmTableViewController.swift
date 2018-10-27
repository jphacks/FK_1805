//
//  AlarmTableViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController {

    // MARK: - Propaties

    private var alarms:[Alarm] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshData(sender:)), for: .valueChanged)
    }

    private func setup() {
        let data = Array(Alarm.read())
        self.alarms = data
        self.tableView.reloadData()
    }

    @objc func refreshData(sender: UIRefreshControl) {
        let data = Array(Alarm.read())
        self.alarms = data
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
        let targetAlarm = self.alarms[indexPath.item]
        cell.update(target: targetAlarm)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let targetAlarm = self.alarms[indexPath.item]
            Alarm.delete(alarm: targetAlarm)
            self.alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            return
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
