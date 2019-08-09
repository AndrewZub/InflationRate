//
//  RequestProtocol.swift
//  Utils
//
//  Created by Николай Садчиков on 03/06/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestProtocol {
    var baseURLString: String { get set }
    var parameters: Parameters? { get set }
    var headers: HTTPHeaders? { get set }
    func baseURL () -> String
    func path () -> String
    func method () -> HTTPMethod
}

public extension RequestProtocol {
    
    func baseURL () -> String {
        return baseURLString
    }
    
    mutating func setAuthorizationToken(token: String?) {
        guard let token = token else {
            return
        }
        if headers == nil {
            headers = [:]
        }
        let currentLocale = Locale.current
        headers?["Accept-Language"] = currentLocale.languageCode
        headers?["Authorization"] = "Bearer ".appending(token)
    }
    
    mutating func setAcceptLanguage() {
        if headers == nil {
            headers = [:]
        }
        let currentLocale = Locale.current
        headers?["Accept-Language"] = currentLocale.languageCode
    }
}
