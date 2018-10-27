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
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            if let data = data {
//                let image = UIImage(data: data)
//                DispatchQueue.main.async {
//                    self.imageView.image = image?.cropping2square()
//                }
//                completion(image)
//            }
//        }.resume()
        
        self.imageView.kf.setImage(with: url) { (image, error, _, _) in
            if error == nil {
                completion(image)
            }
        }
    }
}
