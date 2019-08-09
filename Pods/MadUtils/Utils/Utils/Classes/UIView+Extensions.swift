//
//  UIView+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 28/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

public extension UIView {
    
    func addBlur(color: UIColor, style: UIBlurEffect.Style = .dark) {
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.contentView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    func removeBlur() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func roundCorners(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func circularCorners() {
        self.roundCorners(radius: self.bounds.height * 0.5)
    }
    
    func pin(to view: UIView, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftOffset),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightOffset),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomOffset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setShadows(offset: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.clear
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    func addPulseAnimation(duration: CFTimeInterval, repeatCount: Float) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 1.0
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .greatestFiniteMagnitude
        pulse.initialVelocity = 0.5
        pulse.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = duration
        animationGroup.repeatCount = repeatCount
        animationGroup.animations = [pulse]
        
        self.layer.add(animationGroup, forKey: "pulse")
    }
    
    func setBorderAndRoundCorners(width: CGFloat, radius: CGFloat, color: UIColor? = nil) {
        layer.borderWidth = width
        layer.borderColor = color?.cgColor ?? UIColor.black.cgColor
        roundCorners(radius: radius)
    }
}
