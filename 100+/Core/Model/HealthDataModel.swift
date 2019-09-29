//
//  HealthDataModel.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import RealmSwift

class HealthDataModel: Object {
    
    @objc dynamic var height = Double(0)
    @objc dynamic var weight = Double(0)
    @objc dynamic var age = Int(0)
    @objc dynamic var sex = -1
    @objc dynamic var smoking = -1
    @objc dynamic var relativeStroke = -1
    @objc dynamic var bpm = 0
    @objc dynamic var steps = 1000
    @objc dynamic var primaryKey = "primaryKey"
    
    // - Layout
    @objc dynamic var title = ""
    @objc dynamic var color = ""
    @objc dynamic var index = 0
    
    override class func primaryKey() -> String? {
        return "primaryKey"
    }

}
