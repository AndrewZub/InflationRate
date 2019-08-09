//
//  YearObject.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 05/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import RealmSwift
import ObjectMapper

@objcMembers
final class Inflation: Object, Mappable {
    
    dynamic var year = 0
    dynamic var total = 0.0
    var months = List<Month>()
    
    override static func primaryKey() -> String? {
        return #keyPath(Inflation.year)
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if let yearInt = (map["﻿Year"].currentValue as? NSString)?.integerValue,
            let totalInt = (map[" Total"].currentValue as? NSString)?.doubleValue {
            year = yearInt
            total = totalInt
        }
        mapMonth(with: map[" January"].currentKey, value: map[" January"].currentValue as? NSString)
        mapMonth(with: map[" February"].currentKey, value: map[" February"].currentValue as? NSString)
        mapMonth(with: map[" March"].currentKey, value: map[" March"].currentValue as? NSString)
        mapMonth(with: map[" April"].currentKey, value: map[" April"].currentValue as? NSString)
        mapMonth(with: map[" May"].currentKey, value: map[" May"].currentValue as? NSString)
        mapMonth(with: map[" June"].currentKey, value: map[" June"].currentValue as? NSString)
        mapMonth(with: map[" July"].currentKey, value: map[" July"].currentValue as? NSString)
        mapMonth(with: map[" August"].currentKey, value: map[" August"].currentValue as? NSString)
        mapMonth(with: map[" September"].currentKey, value: map[" September"].currentValue as? NSString)
        mapMonth(with: map[" October"].currentKey, value: map[" October"].currentValue as? NSString)
        mapMonth(with: map[" November"].currentKey, value: map[" November"].currentValue as? NSString)
        mapMonth(with: map[" December"].currentKey, value: map[" December"].currentValue as? NSString)
    }
    
    func mapMonth(with key: String?, value: NSString?) {
        let month = Month()
        month.name = key ?? ""
        month.value = value?.doubleValue ?? 0.0
        months.append(month)
    }
}
