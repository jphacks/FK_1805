//
//  Helper Files.swift
//  WildCat
//
//  Created by Azuma on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

enum SegmentStatus {
    case Twitter
    case Save
}

@IBDesignable class RoundButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0

    override func draw(_ rect: CGRect) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }

}
