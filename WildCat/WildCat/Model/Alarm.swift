//
//  Alarm.swift
//  WildCat
//
//  Created by Azuma on 2018/10/23.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import RealmSwift

class Alarm: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date: Date = Date()
    @objc dynamic var pattern: Pattern?
}
