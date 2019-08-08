//
//  RealmFactory.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 06/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import RealmSwift

final class RealmFactory {
    static private let schemaVersion: UInt64 = 5
    
    static func getRealm() -> Realm {
        let schemaVersion = RealmFactory.schemaVersion
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { _, _ in
        })
        // swiftlint:disable force_try
        let realm = try! Realm(configuration: config)
        return realm
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
