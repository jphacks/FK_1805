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
        self.imageView.kf.setImage(with: URL(string: photo.imagePath)!) { (image, error, _, _) in
            if error == nil {
                completion(image)
            }
        }
    }
}
