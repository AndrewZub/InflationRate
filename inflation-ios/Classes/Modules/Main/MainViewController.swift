//
//  MainViewController.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 02/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import UIKit


final class MainViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let heightRow: CGFloat = 64
        static let headerHeight: CGFloat = 86
        static let animateDuration: TimeInterval = 0.10
    }
    
    // MARK: - Outlets
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.register(MainHeader.nib, forHeaderFooterViewReuseIdentifier: MainHeader.reuseIdentifier)
            tableView.register(R.nib.mainCell)
        }
    }
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    // MARK: - Properties
    var presenter: MainViewPresenter!
    private var expandedSections = [Int]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getInflation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = R.string.localization.mainNavTitle()
    }
}

// MARK: - UITableViewDelegate'n'Datasoure
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainHeader.reuseIdentifier) as? MainHeader else {
            return nil
        }
        view.delegate = self
        guard let year = presenter.inflations?[section] else {
            return UIView()
        }
        view.configure(with: year, section: section, isCollapsed: expandedSections.contains(section))
        return view
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.inflations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if expandedSections.contains(section) {
            return presenter.inflations?[section].months.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mainCell, for: indexPath)!
        guard let month = presenter.inflations?[indexPath.section].months[indexPath.row] else {
            return UITableViewCell()
        }
        cell.configure(with: month)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.heightRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightRow
    }
}

extension MainViewController: MainHeaderDelegate {
    func expand(section: Int) {
        let shouldExpand = !expandedSections.contains(section)
        expandedSections.removeAll()
        if shouldExpand {
            expandedSections.append(section)
        }
        tableView.reloadData()
        if shouldExpand {
            let indexPath = IndexPath(item: 0, section: section)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        UIView.animate(withDuration: Constants.animateDuration) { [weak self] in
            self?.view.setNeedsLayout()
        }
    }
}

extension MainViewController: MainViewProtocol {
    
    func showLoader() {
        tableView.isHidden = true
        loader.startAnimating()
    }
    
    func showError() {
        Alert.showAlert(with: R.string.localization.mainErrorMessage())
    }
    
    func dataDidLoad() {
        tableView.reloadData()
        loader.stopAnimating()
        tableView.isHidden = false
    }
}
