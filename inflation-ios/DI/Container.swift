//
//  Container.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 02/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        
        defaultContainer.register(MainService.self) { (r) in
            MainService()
        }.inObjectScope(.container)
        
        
        defaultContainer.storyboardInitCompleted(UINavigationController.self) { (_, _) in
        }
        defaultContainer.storyboardInitCompleted(UITabBarController.self) { (_, _) in
        }
        defaultContainer.storyboardInitCompleted(TabBarController.self) { (_, _) in
        }
        defaultContainer.storyboardInitCompleted(MainViewController.self) { (r, c) in
            c.presenter = MainPresenter(with: c, mainService: r.resolve(MainService.self)!)
        }
        defaultContainer.storyboardInitCompleted(CalculatorViewController.self) { (r, c) in
            c.presenter = CalculatorPresenter(with: r.resolve(MainService.self)!)
        }
    }
}
