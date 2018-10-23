//
//  Pattern.swift
//  WildCat
//
//  Created by Azuma on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import RealmSwift

class Pattern: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var message: String = ""
    @objc dynamic var imagePath: String = ""
}
