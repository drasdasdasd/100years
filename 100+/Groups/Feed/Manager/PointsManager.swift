//
//  PointsManager.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class PointsManager {
    
    // - Manager
    private let hkManager = HealthKitManager()
    
    func getSteps(completion: @escaping ((_ steps: [StepModel]) -> Void)) {
        var values = [StepModel]()
        let now = Date()
        for index in 0...15 {
            let date = now.date(days: -index) ?? Date()
            hkManager.getSteps(date: date) { (steps) in
                values.append(StepModel(date: date, steps: Int(steps)))
                if index == 15 {
                    completion(values)
                }
            }
        }
    }

}
