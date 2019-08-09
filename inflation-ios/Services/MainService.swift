//
//  MainService.swift
//  inflation-ios
//
//  Created by Андрей Зубехин on 05/08/2019.
//  Copyright © 2019 MAD. All rights reserved.
//

import Alamofire
import CSwiftV
import ObjectMapper
import RealmSwift

typealias InflationsUpdated = () -> Void
typealias GetInflationsCompletion = (_ error: Error?) -> Void

final class MainService {
    
    private var realmInflations: Results<Inflation>!
    private var notifcationToken: NotificationToken?
    private(set) var inflations: [Inflation]?
    var update: [InflationsUpdated?] = []

    init() {
        let realm = RealmFactory.getRealm()
        self.realmInflations = realm.objects(Inflation.self).sorted(byKeyPath: #keyPath(Inflation.year), ascending: false)
        self.notifcationToken?.invalidate()
        self.notifcationToken = realmInflations?.observe({ [weak self] (changes) in
            guard let `self` = self else {
                return
            }
            self.inflations = self.realmInflations?.toArray(ofType: Inflation.self)
            for update in self.update {
                update?()
            }
        })
    }
    
    func getInflation(completion: @escaping GetInflationsCompletion) {
        let url = "https://storage.googleapis.com/ytaxi-testing/inflation.csv"
        AF.request(url).responseJSON() {
            response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let csvTest = CSwiftV(with: utf8Text)
                if let keyedRows = csvTest.keyedRows {
                    let inflations = Mapper<Inflation>().mapArray(JSONArray: keyedRows)
                    self.updateLocalInflations(with: inflations)
                }
            }
        }
    }
    
    private func updateLocalInflations(with newInflations: [Inflation]) {
        let realm = RealmFactory.getRealm()
        for newInflation in newInflations {
            do {
                try realm.write {
                    realm.create(Inflation.self, value: newInflation, update: .all)
                }
            } catch let ex {
                print(ex)
            }
        }
    }
}
