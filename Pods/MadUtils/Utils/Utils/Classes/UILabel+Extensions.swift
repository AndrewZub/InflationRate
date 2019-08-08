//
//  UILabel+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

public extension UILabel {
    
    func addImage(image: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = image
        let attachmentString = NSAttributedString(attachment: attachment)
        let text = self.text!.appending(" ")
        let myString = NSMutableAttributedString(string: text)
        myString.append(attachmentString)
        self.attributedText = myString
    }
    
    func adjustFontSizeToFit(minimumFontSize: CGFloat, maximumFontSize: CGFloat? = nil) {
        let maxFontSize = maximumFontSize ?? font.pointSize
        let constraintSize = CGSize(width: bounds.size.width, height: CGFloat(MAXFLOAT))
        
        for size in stride(from: maxFontSize, to: minimumFontSize, by: -CGFloat(10)) {
            let proposedFont = font.withSize(size)
            let labelSize = ((text ?? "") as String).boundingRect(with: constraintSize,
                                                                  options: .usesLineFragmentOrigin,
                                                                  attributes: [NSAttributedString.Key.font: proposedFont],
                                                                  context: nil)
            if labelSize.height <= bounds.size.height {
                font = proposedFont
                setNeedsLayout()
                break
            }
        }
    }
}
