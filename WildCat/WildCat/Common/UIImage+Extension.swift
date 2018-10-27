//
//  UIImage+Extension.swift
//  WildCat
//
//  Created by Azuma on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

extension UIImage {
    func cropping2square()-> UIImage!{
        let cgImage    = self.cgImage
        let width = (cgImage?.width)!
        let height = (cgImage?.height)!
        let resizeSize = min(height,width)

        let cropCGImage = self.cgImage?.cropping(to: CGRect(x: (width - resizeSize) / 2, y: (height - resizeSize) / 2, width: resizeSize, height: resizeSize))

        let cropImage = UIImage(cgImage: cropCGImage!)

        return cropImage
    }
}
