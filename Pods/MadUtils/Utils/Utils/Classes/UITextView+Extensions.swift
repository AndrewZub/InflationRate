//
//  UITextView+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

extension UITextView: UITextViewDelegate {
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    public var placeholder: String? {
        get {
            var placeholderText: String?
            if let placeholderLabel = self.viewWithTag(50) as? UILabel {
                placeholderText = placeholderLabel.text
                placeholderLabel.isHidden = self.text != ""
            }
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(50) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.isHidden = self.text != ""
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(50) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
        setNeedsUpdateConstraints()
    }
    
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(50) as! UILabel? {
            let x: CGFloat = 0
            let y = self.textContainerInset.top - 2
            let width = self.frame.width - (x * 2)
            let height = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: x, y: y, width: width, height: height)
            placeholderLabel.sizeToFit()
        }
    }
    
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.gray
        placeholderLabel.tag = 50
        
        placeholderLabel.isHidden = self.text.count > 0
        self.addSubview(placeholderLabel)
        placeholderLabel.pin(to: self)
        self.resizePlaceholder()
    }
    
    public func setPlaceholderHiddenIfNeeded(some info: String) {
        if let placeholderLabel = self.viewWithTag(50) as? UILabel {
            placeholderLabel.isHidden = info != ""
            self.textColor = info != "" ? UIColor.white : UIColor.gray
            self.setNeedsLayout()
        }
    }
}
