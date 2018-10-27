//
//  PhotoManager.swift
//  WildCat
//
//  Created by 山浦功 on 2018/10/26.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import Photos

class PhotoManager {

    class func getImageWithID(id: String, complition: @escaping (UIImage?) -> Void) {
        if let asset = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil).firstObject {
            PHImageManager.default().requestImageData(for: asset, options: nil) { (data, _, _, _) in
                var image: UIImage?
                if let data = data {
                    image = UIImage(data: data)
                }
                complition(image)
            }
        }
    }

    class func getImageWithURL(stringURL: String, complition: @escaping (UIImage?) -> Void) {
        if let asset = PHAsset.fetchAssets(withALAssetURLs: [URL(string: stringURL)!], options: nil).firstObject {
            PHImageManager.default().requestImageData(for: asset, options: nil) { (data, _, _, _) in
                var image: UIImage? = nil
                if let data = data {
                    image = UIImage(data: data)
                }
                complition(image)
            }
        }
    }
}
