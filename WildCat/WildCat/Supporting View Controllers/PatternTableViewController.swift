//
//  PatternTableViewController.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

public class PatternTableViewController: UITableViewController {

    var patterns:[Pattern] = []

    // MARK: - Table view data source

    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patterns.count
    }

    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "patternCell", for: indexPath) as! PatternTableViewCell
        let targetPattern = self.patterns[indexPath.item]
        var image = UIImage(named: "black")!
        LocalPhoto.load(localIdentifer: targetPattern.imagePath) { (resultImage) in
            if let resultImage = resultImage {
                image = resultImage
            }
        }
        cell.update(message: targetPattern.message, photo: image)
        return cell
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(105)
    }
}

