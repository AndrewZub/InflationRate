//
//  Main.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 02/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import UIKit
import MadUtils

protocol MainHeaderDelegate: class {
    func expand(section: Int)
}

final class MainHeader: UITableViewHeaderFooterView {

    // MARK: - Outlets
    @IBOutlet private var yearLabel: UILabel!
    @IBOutlet private var arrow: UIImageView!
    @IBOutlet private var totalLabel: UILabel!
    @IBOutlet var expandableButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: MainHeaderDelegate?
    static let reuseIdentifier: String = String(describing: self)
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    var isExpanded = false
    
    // MARK: - Methods
    func configure(with model: Inflation, section: Int, isCollapsed: Bool) {
        yearLabel.text = "\(model.year)"
        totalLabel.text = "\(model.total)"
        expandableButton.tag = section
        arrow.image = isCollapsed ? R.image.upArrow() : R.image.arrow()
    }
    
    // MARK: - IBAction
    @IBAction
    func expand(_ sender: UIButton) {
        delegate?.expand(section: sender.tag)
    }
}
