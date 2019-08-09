//
//  GradientButton.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

open class GradientButton: UIButton {
    
    public var gradientColors = (start: UIColor.yellow, end: UIColor.orange)
    
    private lazy var gradientView: EZYGradientView = {
        let gradientView = EZYGradientView()
        gradientView.colorRatio = 0.4
        gradientView.firstColor = gradientColors.start
        gradientView.secondColor = gradientColors.end
        gradientView.fadeIntensity = 0.6
        gradientView.angleº = 90
        gradientView.isUserInteractionEnabled = false
        return gradientView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setup() {
        insertSubview(gradientView, at: 0)
        gradientView.pin(to: self)
        gradientView.isHidden = true
    }
    
    open func fillGradient() {
        UIView.animate(withDuration: 0.2) {
            self.gradientView.isHidden = false
            self.setTitleColor(.white, for: .normal)
            self.setNeedsLayout()
        }
    }
    
    open func unfillGradient() {
        gradientView.isHidden = true
        setTitleColor(.black, for: .normal)
    }
}
