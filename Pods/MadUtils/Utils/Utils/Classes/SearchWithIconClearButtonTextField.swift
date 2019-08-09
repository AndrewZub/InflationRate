//
//  SearchWithIconStandartClearButtonTextField.swift
//  galt
//
//  Created by Николай Садчиков on 13/12/2018.
//  Copyright © 2018 GALT. All rights reserved.
//

import UIKit

public class SearchWithIconClearButtonTextField: UITextField {
    
    var fontColor = UIColor.darkGray
    
    var clearButtonImage: UIImage? {
        didSet {
            layoutSubviews()
        }
    }
    
    var searchImage: UIImage? {
        didSet {
            layoutSubviews()
        }
    }
    
    var searchImageColor = UIColor.darkGray {
        didSet {
            layoutSubviews()
        }
    }
    
    var leftPadding: CGFloat = 32 {
        didSet {
            layoutSubviews()
        }
    }
    
    override public var placeholder: String? {
        didSet {
            let attributedString = NSAttributedString(string: placeholder!, attributes: [.foregroundColor : fontColor])
            self.attributedPlaceholder = attributedString
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        for view in subviews {
            if let imageView = view as? UIImageView {
                imageView.image = searchImage
                imageView.tintColor = searchImageColor
                setLeftPaddingPoints(amount: leftPadding)
            }
            
            if let button = view as? UIButton {
                if let image = clearButtonImage {
                    button.setImage(image, for: .normal)
                } else {
                    button.setImage(UIImage(), for: .normal)
                }
                
                var frame = button.frame
                frame.size = CGSize(width: 21, height: 21)
                button.frame = frame
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        let imageView = UIImageView(image: searchImage)
        imageView.tintColor = searchImageColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 14),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1)
        ]
        NSLayoutConstraint.activate(constraints)
        setLeftPaddingPoints(amount: leftPadding)
    }
}
