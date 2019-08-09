//
//  Alert.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 08/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import UIKit

final class Alert {
    static func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(ok)
        if let topVC = UIApplication.shared.keyWindow?.rootViewController {
            topVC.present(alertController, animated: true, completion: nil)
        }
    }
}
