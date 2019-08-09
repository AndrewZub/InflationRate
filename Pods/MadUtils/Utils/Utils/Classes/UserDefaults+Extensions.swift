//
//  UserDefaults+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 10/06/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    func decode<T: Codable>(for type: T.Type, using key: String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {
            return nil
        }
        let decodedObject = try? PropertyListDecoder().decode(type, from: data)
        return decodedObject
    }
    
    func encode<T: Codable>(for type: T, using key: String) {
        let defaults = UserDefaults.standard
        let encodedData = try? PropertyListEncoder().encode(type)
        defaults.set(encodedData, forKey: key)
        defaults.synchronize()
    }
}
