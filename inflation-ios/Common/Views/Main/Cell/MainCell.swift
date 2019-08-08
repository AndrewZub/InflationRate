//
//  MainCell.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 05/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import UIKit

final class MainCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private var monthLabel: UILabel!
    @IBOutlet private var inflationLabel: UILabel!

    // MARK: - Methods
    func configure(with model: Month) {
        monthLabel.text = model.name
        inflationLabel.text = model.value == 0.0 ? "––" : "\(model.value)"
    }
}
