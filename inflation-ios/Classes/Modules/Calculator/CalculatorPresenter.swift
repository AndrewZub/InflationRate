//
//  CalculatorPresenter.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 07/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

protocol CalculatorViewPresenter {
    init(with mainService: MainService)
    var inflations: [Inflation]? { get }
    func calculateInflation(from startPeriod: (year: Int, month: String), to endPeriod: (year: Int, month: String)) -> (countMonths: Int, amount: Double)
}

final class CalculatorPresenter: CalculatorViewPresenter {
    
    // MARK: - Properties
    var inflations: [Inflation]? {
        get {
            return mainService.inflations
        }
    }
    
    var mainService: MainService!
    
    // MARK: - Methods
    init(with mainService: MainService) {
        self.mainService = mainService
    }
    
    func calculateInflation(from startPeriod: (year: Int, month: String), to endPeriod: (year: Int, month: String)) -> (countMonths: Int, amount: Double) {
        guard let inflations = inflations else {
            return (.zero, .zero)
        }
        if (endPeriod.year - startPeriod.year) > 1 {
            if let firstIndex = inflations.firstIndex(where: { $0.year == startPeriod.year }),
                let lastIndex = inflations.firstIndex(where: { $0.year == endPeriod.year }) {
                var sum = 0.0
                let newInflations =  Array(inflations[lastIndex + 1...firstIndex - 1])
                sum = newInflations.reduce(0, { $0 + $1.total })
                let startMonthIndex = inflations[firstIndex].months.firstIndex(where: { $0.name == startPeriod.month }) ?? 0
                let endMonthIndex = inflations[lastIndex].months.firstIndex(where: { $0.name == endPeriod.month }) ?? 0
                let endIndex = inflations[firstIndex].months.endIndex
                let firstMonths = Array(inflations[firstIndex].months[startMonthIndex...endIndex - 1])
                let secondMonts = Array(inflations[lastIndex].months[0...endMonthIndex])
                let rangeOfMonths = firstMonths + secondMonts
                sum += rangeOfMonths.reduce(0, { $0 + $1.value })
                print(sum)
                return (rangeOfMonths.count, sum)
            }
        } else if startPeriod.year == endPeriod.year {
            guard let inflation = inflations.first(where: {$0.year == startPeriod.year }) else {
                return (.zero, .zero)
            }
            var sum = 0.0
            let startMonthIndex = inflation.months.firstIndex(where: { $0.name == startPeriod.month }) ?? 0
            let endMonthIndex = inflation.months.firstIndex(where: { $0.name == endPeriod.month }) ?? 0
            if startMonthIndex == 0 && endMonthIndex == 11 {
                sum = inflation.total
                return (inflation.months.count, sum)
            }
            let rangeOfMonths = Array(inflation.months[startMonthIndex...endMonthIndex])
            sum = rangeOfMonths.reduce(0, { $0 + $1.value })
            print(sum)
            return (rangeOfMonths.count, sum)
        } else if (endPeriod.year - startPeriod.year) == 1 {
            guard let startInfrationPeriod = inflations.first(where: { $0.year == startPeriod.year }), let endInflationPeriod = inflations.first(where: { $0.year == endPeriod.year }) else {
                return (.zero, .zero)
            }
            let startMonthIndex = startInfrationPeriod.months.firstIndex(where: { $0.name == startPeriod.month }) ?? 0
            let endMonthIndex = endInflationPeriod.months.firstIndex(where: { $0.name == endPeriod.month }) ?? 0
            let fisrtMonths = Array(startInfrationPeriod.months[startMonthIndex...startInfrationPeriod.months.endIndex - 1])
            let secondMonths = Array(endInflationPeriod.months[0...endMonthIndex])
            let rangeOfMonths = fisrtMonths + secondMonths
            let sum = rangeOfMonths.reduce(0, { $0 + $1.value })
            print(sum)
            return (rangeOfMonths.count, sum)
        }
        return (.zero, .zero)
    }
}
