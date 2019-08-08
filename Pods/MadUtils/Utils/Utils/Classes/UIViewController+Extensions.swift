//
//  UIViewController+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 31/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    func add(childViewController: UIViewController, to view: UIView) {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        containerView.pin(to: view)
        
        // add child view controller view to container
        
        addChild(childViewController)
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(childViewController.view)
        
        childViewController.view.pin(to: containerView)
        
        childViewController.didMove(toParent: self)
    }
    
    func hideNavigationBarOnScrolling(scrollView: UIScrollView, hideOffset: CGFloat? = -100, showOffset: CGFloat? = 100) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        if velocity < hideOffset ?? -100 {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: false)
            }, completion: nil)
        } else if velocity > showOffset ?? 100 {
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: false)
            }, completion: nil)
        }
    }
}
