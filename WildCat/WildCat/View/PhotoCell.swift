//
//  PhotoCell.swift
//  WildCat
//
//  Created by Azuma on 2018/10/24.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    func configure(photo: Photo, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: photo.imagePath) else {
            self.imageView.image = UIImage(named: "black")
            return
        }
        imageView.cacheImage(with: url) { (image) in
            completion(image)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.imageView.image = nil
    }
}
