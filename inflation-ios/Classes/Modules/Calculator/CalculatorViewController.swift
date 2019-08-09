//
//  CalculatorViewController.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 02/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import UIKit
import MadUtils

final class CalculatorViewController: UIViewController {
    
    // MARK: - Nested enum
    private enum Constants {
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 6
        static let leftPadding: CGFloat = 8
    }
    
    private enum Components: Int, CaseIterable {
        case year = 0
        case month = 1
    }
    
    // MARK: - Outlets
    @IBOutlet private var startPeriodLabel: UILabel!
    @IBOutlet private var endPeriodLabel: UILabel!
    @IBOutlet private var startPeriodTextField: UITextField!
    @IBOutlet private var endPeriodTextField: UITextField!
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var calculate: UIButton!
    
    // MARK: - Properties
    var presenter: CalculatorViewPresenter!
    private let startPeriodPicker = UIPickerView()
    private let endPeriodPicker = UIPickerView()
    private var startPeriod, endPeriod: (year: Int, month: String)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startPeriodPicker.delegate = self
        startPeriodPicker.dataSource = self
        endPeriodPicker.delegate = self
        endPeriodPicker.dataSource = self
        setupInitial()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = R.string.localization.calculatorNaTitle()
    }
    
    // MARK: - Methods
    private func setupInitial() {
        startPeriodLabel.text = R.string.localization.calculatorStartPeriod()
        startPeriodLabel.textColor = .white
        endPeriodLabel.textColor = .white
        endPeriodLabel.text = R.string.localization.calculatorEndPeriod()
        startPeriodTextField.setLeftPaddingPoints(amount: Constants.leftPadding)
        endPeriodTextField.setLeftPaddingPoints(amount: Constants.leftPadding)
        startPeriodTextField.setBorderAndRoundCorners(width: Constants.borderWidth, radius: Constants.cornerRadius, color: .gray)
        endPeriodTextField.setBorderAndRoundCorners(width: Constants.borderWidth, radius: Constants.cornerRadius, color: .gray)
        startPeriodTextField.inputView = startPeriodPicker
        endPeriodTextField.inputView = endPeriodPicker
        calculate.setBorderAndRoundCorners(width: Constants.borderWidth, radius: Constants.cornerRadius, color: .orange)
        calculate.setTitle(R.string.localization.calculatorCalculateTitle(), for: .normal)
    }
    
    private func check(data: (year: Int, month: String)) -> Bool {
        guard let inflations = presenter.inflations else {
            return false
        }
        if let inflation = inflations.first(where: { $0.year == data.year }),
            let month = inflation.months.first(where: { $0.name == data.month}) {
            if month.value.isZero {
                return true
            }
        }
        return false
    }
    
    private func hightlightField(isStartPeriod: Bool) {
        if let startPeriod = startPeriodTextField.text, startPeriod.isEmpty && isStartPeriod {
            startPeriodLabel.textColor = .red
            startPeriodTextField.layer.borderColor = UIColor.red.cgColor
        }
        if let endPeriod = endPeriodTextField.text, endPeriod.isEmpty && !isStartPeriod {
            endPeriodLabel.textColor = .red
            endPeriodTextField.layer.borderColor = UIColor.red.cgColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.setupInitial()
        }
    }
    
    @IBAction
    private func calculate(_ sender: UIButton) {
        view.endEditing(true)
        if let startText = startPeriodTextField.text, let endText = endPeriodTextField.text, startText.isEmpty || endText.isEmpty {
            Alert.showAlert(with: R.string.localization.calculatorErrorEmptyField())
            return
        }
        if let startPeriod = startPeriod, let endPeriod = endPeriod  {
            if startPeriod.year > endPeriod.year {
                Alert.showAlert(with: R.string.localization.calculatorErrorWrongPeriod())
                return
            }
            let result = presenter.calculateInflation(from: startPeriod, to: endPeriod)
            resultLabel.text = R.string.localization.calculatorInflation( R.string.localizable.months(value: result.countMonths), result.amount)
        }
    }
}

// MARK: - UIPickerViewDelegate'n'UIPickerViewDataSource
extension CalculatorViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Components.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case Components.year.rawValue:
            return presenter.inflations?.count ?? 0
        case Components.month.rawValue:
            return presenter.inflations?[component].months.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case Components.year.rawValue:
            return "\(presenter.inflations?[row].year ?? 0)"
        case Components.month.rawValue:
            return presenter.inflations?[component].months[row].name
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let year = presenter.inflations?[pickerView.selectedRow(inComponent: Components.year.rawValue)].year ?? 0
        let month = presenter.inflations?[pickerView.selectedRow(inComponent: Components.year.rawValue)].months[pickerView.selectedRow(inComponent: Components.month.rawValue)].name ?? ""
        switch pickerView {
        case startPeriodPicker:
            if check(data: (year, month)) {
                hightlightField(isStartPeriod: true)
            } else {
                startPeriod = (year, month)
                startPeriodTextField.text = "\(year), \(month)"
            }
        case endPeriodPicker:
            if check(data: (year, month)) {
                hightlightField(isStartPeriod: false)
            } else {
                endPeriod = (year, month)
                endPeriodTextField.text = "\(year), \(month)"
            }
        default:
            break
        }
    }
}
