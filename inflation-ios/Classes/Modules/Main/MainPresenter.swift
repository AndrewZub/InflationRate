//
//  MainPresenter.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 06/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

protocol MainViewProtocol: class {
    func showError()
    func showLoader()
    func dataDidLoad()
}

protocol MainViewPresenter {
    init(with view: MainViewProtocol, mainService: MainService)
    var inflations: [Inflation]? { get }
    func getInflation()
}

final class MainPresenter: MainViewPresenter {
    
    // MARK: - Properties
    var inflations: [Inflation]? {
        get {
            return mainService.inflations
        }
    }
    
    weak var view: MainViewProtocol?
    var mainService: MainService!
    
    // MARK: - Methods
    init(with view: MainViewProtocol, mainService: MainService) {
        self.view = view
        self.mainService = mainService
        self.mainService.update.append({ [weak self] in
            self?.view?.dataDidLoad()
        })
    }
    
    func getInflation() {
        if inflations == nil {
            view?.showLoader()
        }
        mainService.getInflation { [weak self] (error) in
            guard let `self` = self else {
                return
            }
            defer {
                self.view?.dataDidLoad()
            }
            guard error == nil else {
                self.view?.showError()
                return
            }
        }
    }
}
