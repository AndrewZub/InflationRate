//
//  StoreReviewHelper.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import StoreKit

public struct StoreReviewHelper {
    
    public static let userDefaultsAppOpenedKey = "appOpenedCount"
    public static var appId = ""
    
    public static func incrementAppOpenedCount() {
        let userDefaults = UserDefaults.standard
        var appOpenCount = userDefaults.integer(forKey: StoreReviewHelper.userDefaultsAppOpenedKey)
        appOpenCount += 1
        userDefaults.set(appOpenCount, forKey: StoreReviewHelper.userDefaultsAppOpenedKey)
        userDefaults.synchronize()
    }
    
    public static func checkAndAskForReview() {
        let userDefaults = UserDefaults.standard
        let appOpenCount = userDefaults.integer(forKey: StoreReviewHelper.userDefaultsAppOpenedKey)
        
        switch appOpenCount {
        case 10, 50:
            StoreReviewHelper.requestReview()
        case _ where appOpenCount % 100 == 0 :
            StoreReviewHelper.requestReview()
        default:
            break;
        }
    }
    
    static public func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            let urlString = "itms-apps://itunes.apple.com/app/".appending(StoreReviewHelper.appId)
            let url = URL(string: urlString)!
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
