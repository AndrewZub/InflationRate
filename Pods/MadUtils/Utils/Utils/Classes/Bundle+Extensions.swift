//
//  Bundle+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 10/06/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import Foundation

public extension Bundle {
    
    static var appLanguage = "ru"
    
    static func swizzleLocalization() {
        let orginalSelector = #selector(localizedString(forKey:value:table:))
        guard let orginalMethod = class_getInstanceMethod(self, orginalSelector) else {
            return
        }
        
        let mySelector = #selector(myLocaLizedString(forKey:value:table:))
        guard let myMethod = class_getInstanceMethod(self, mySelector) else {
            return
        }
        
        if class_addMethod(self, orginalSelector, method_getImplementation(myMethod), method_getTypeEncoding(myMethod)) {
            class_replaceMethod(self, mySelector, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod))
        } else {
            method_exchangeImplementations(orginalMethod, myMethod)
        }
    }
    
    @objc private func myLocaLizedString(forKey key: String, value: String?, table: String?) -> String {
        guard let bundlePath = Bundle.main.path(forResource: Bundle.appLanguage, ofType: "lproj"),
            let bundle = Bundle(path: bundlePath) else {
                return Bundle.main.myLocaLizedString(forKey: key, value: value, table: table)
        }
        return bundle.myLocaLizedString(forKey: key, value: value, table: table)
    }
}
