//
//  PhotoPickerCell.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

class PhotoPickerCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    func update(image: UIImage) {
        self.photoImageView.image = image
    }
}
