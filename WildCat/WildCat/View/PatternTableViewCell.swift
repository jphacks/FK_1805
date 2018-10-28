//
//  PatternTableViewCell.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/24.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Photos

class PatternTableViewCell: UITableViewCell {

    @IBOutlet weak private var photoImage: UIImageView!
    @IBOutlet weak private var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(message: String, photo: UIImage) {
        self.messageLabel.text = message
        self.photoImage.image = photo.cropping2square()
    }
}
