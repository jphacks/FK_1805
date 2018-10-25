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

extension Pattern {
    class func add(pattern: Pattern) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(pattern)
            }
        } catch {
            print(error)
        }
    }

    class func update(pattern: Pattern, block: (Results<Pattern>) -> Void) {
        let realm = try! Realm()
        add(pattern: pattern)
        block(realm.objects(Pattern.self))
    }

    class func delete(pattern: Pattern) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(pattern)
            }
        } catch {
            print(error)
        }
    }

    class func deleteAll() {
        do {
            let realm = try Realm()
            let allPattern = realm.objects(Pattern.self)
            try realm.write {
                realm.delete(allPattern)
            }
        } catch {
            print(error)
        }
    }
}
