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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.refreshData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.segueToAdd))
    }

    @objc func refreshData() {
        let data = Array(Pattern.read())
        self.patterns = data
        self.tableView.reloadData()
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let targetPattern = self.patterns[indexPath.item]
            Pattern.delete(pattern: targetPattern)
            self.patterns.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            return
        }
    }
}
