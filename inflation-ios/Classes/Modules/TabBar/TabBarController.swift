//
//  TabBarViewController.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 02/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .gray
        tabBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitles()
    }
    
    private func setTitles() {
        guard let items = tabBar.items, items.count == 2 else { return }
        let mainItem = items[0]
        let calculatorItem = items[1]
        mainItem.title = R.string.localization.tabBarMainItem()
        calculatorItem.title = R.string.localization.tabBarCalculatorItem()
    }
}
