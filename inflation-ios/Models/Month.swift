//
//  MonthObject.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 05/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers
final class Month: Object, Mappable {
    
    dynamic var name = ""
    dynamic var value = 0.0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        name <- map["key"]
        value <- map["value"]
    }
}
