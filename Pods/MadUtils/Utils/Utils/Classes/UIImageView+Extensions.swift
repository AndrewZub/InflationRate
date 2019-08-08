//
//  UIImageView+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 10/06/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import Nuke

public extension UIImageView {
    
    func setImage(url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            self.image = placeholder
            return
        }
        Nuke.loadImage(
            with: url,
            options: ImageLoadingOptions(
                placeholder: placeholder,
                transition: .fadeIn(duration: 0.33)
            ),
            into: self
        )
    }
}

