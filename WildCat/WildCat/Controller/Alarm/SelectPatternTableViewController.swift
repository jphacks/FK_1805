//
//  SelectPatternTableViewController.swift
//  WildCat
//
//  Created by 陰山賢太 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import UIKit

class SelectPatternTableViewController: PatternTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = Array(Pattern.read())
        self.patterns = data
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = self.delegate {
            let target = patterns[indexPath.row]
            delegate.didFinishChoosePattern(pattern: target)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
