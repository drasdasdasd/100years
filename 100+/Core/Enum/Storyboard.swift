//
//  Storyboard.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import Foundation

enum Storyboard: String {
    
    case risk = "Risk"
    case main = "Main"
    case heartRate = "HeartRate"
    case camera = "Camera"
    case feed = "Feed"
    
    var filename: String {
        return rawValue
    }
    
}
