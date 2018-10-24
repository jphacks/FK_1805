//
//  PatternTableViewCell.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/24.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Kingfisher

class PatternTableViewCell: UITableViewCell {

    @IBOutlet weak private var phtoImage: UIImageView!
    @IBOutlet weak private var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(target model: Pattern) {
        self.messageLabel.text = model.message
        let url = URL(string: model.imagePath)
        self.imageView.kf.setImage(with: url)
    }
}
