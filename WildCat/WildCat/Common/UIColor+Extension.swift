//
//  UIColor+Extension.swift
//  WildCat
//
//  Created by Azuma on 2018/10/24.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alphaHexString: String = "FF") {
        var cString: String = hexString.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet)
            .uppercased()
            .replacingOccurrences(of: "#", with: "")

        if cString.count != 6 {
            cString = "FFFFFF"
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        var alphaValue: UInt32 = 0
        Scanner(string: alphaHexString).scanHexInt32(&alphaValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alphaValue) / 255.0
        )
    }
}

extension UIColor {
    class var background: UIColor {
        return UIColor(hexString: "2D2D2D")
    }

    class var item: UIColor {
        return UIColor(hexString: "FF9500")
    }

    class var label: UIColor {
        return UIColor(hexString: "979797")
    }

    class var title: UIColor {
        return UIColor(hexString: "FFFFFF")
    }
}
