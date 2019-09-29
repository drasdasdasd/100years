//
//  HealthDataBaseManager.swift
//  100+
//
//  Created by Dzianis Baidan on 29/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import RealmSwift

class HealthDataBaseManager: NSObject {
    
    // - Realm
    let realm = try! Realm()
    
}

// MARK: -
// MARK: - Get

extension HealthDataBaseManager {
    
    var healthModel: HealthDataModel? {
        let objects = realm.objects(HealthDataModel.self)
        return Array(objects).first
    }

}


// MARK: -
// MARK: - Save

extension HealthDataBaseManager {
    
    func save(healthModel: HealthDataModel) {
        try? self.realm.write { [weak self] in
            self?.realm.add(healthModel, update: .all)
        }
    }
    
}
