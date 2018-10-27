//
//  UIImageView+Extension.swift
//  WildCat
//
//  Created by Azuma on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()

    func cacheImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        if let imageFromCache = UIImageView.imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            self.image = imageFromCache.cropping2square()
            completion(imageFromCache)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.image = image?.cropping2square()
                    UIImageView.imageCache.setObject(image!, forKey: url.absoluteString as AnyObject)
                    completion(image)
                }
            }
        }.resume()
    }
}
