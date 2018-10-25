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

extension Alarm {
    class func add(alarm: Alarm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(alarm)
            }
        } catch {
            print(error)
        }
    }

    class func update(alarm: Alarm, block: (Results<Alarm>) -> Void) {
        let realm = try! Realm()
        add(alarm: alarm)
        block(realm.objects(Alarm.self))
    }

    class func delete(alarm: Alarm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(alarm)
            }
        } catch {
            print(error)
        }
    }

    class func deleteAll() {
        do {
            let realm = try Realm()
            let allAlarm = realm.objects(Alarm.self)
            try realm.write {
                realm.delete(allAlarm)
            }
        } catch {
            print(error)
        }
    }
}
