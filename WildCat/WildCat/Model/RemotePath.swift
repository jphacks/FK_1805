//
//  RemotePath.swift
//  WildCat
//
//  Created by Azuma on 2018/10/27.
//  Copyright © 2018 Azuma. All rights reserved.
//

import Foundation
import RealmSwift

class RemotePath: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var remotePath: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension RemotePath {
    class func filter(localPath: String) -> Results<RemotePath> {
        let realm = try! Realm()
        let object = realm.objects(RemotePath.self)
        return object.filter("id == %@", localPath)
    }

    class func add(path: RemotePath) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(path)
            }
        } catch {
            print(error)
        }
    }
}
