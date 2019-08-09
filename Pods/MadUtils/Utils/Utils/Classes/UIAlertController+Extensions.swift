//
//  UIAlertController+Additions.swift
//  galt
//
//  Created by Денис Бородавченко on 11.07.2018.
//  Copyright © 2018 GALT. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    public func addActions(actions: [UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
    
    public func setColorsForActions(forCancel: UIColor?, forDefault: UIColor?) {
        for action in actions {
            switch action.style {
            case .cancel:
                action.setValue(forCancel, forKey: "titleTextColor")
            case .destructive:
                break
            case .default:
                action.setValue(forDefault, forKey: "titleTextColor")
            @unknown default:
                break
            }
        }
    }
    
    public func setTitleForPromoActionSheet(text: String, textColor: UIColor, textFont: UIFont) {
        let attributedString = NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.font : textFont,
            NSAttributedString.Key.foregroundColor : textColor
            ])
        self.setValue(attributedString, forKey: "attributedTitle")
    }
}
