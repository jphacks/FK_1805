//
//  PatternTableViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Photos

class ListPatternTableViewController: PatternTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.segueToAdd))
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshData(sender:)), for: .valueChanged)
    }

    @objc func refreshData(sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        let data = Array(Pattern.read())
        self.patterns = data
        self.tableView.reloadData()
        refreshControl?.endRefreshing()
    }

    /// set Datas
    private func setup() {
        let data = Array(Pattern.read())
        self.patterns = data
        self.tableView.reloadData()
    }

    @objc func segueToAdd() {
        let next = UIStoryboard(name: "PatternTableViewController", bundle: nil).instantiateViewController(withIdentifier: "add")
        self.present(next, animated: true, completion: nil)
    }
}
