//
//  RiskModel.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import Foundation

class RiskModel: Decodable {
    
    var teeth = Double(0)
    var face = Double(0)
    
    enum CodingKeys: String, CodingKey {
        case teeth = "teeth_plaque_percentage"
        case face = "face_redness_percentage"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teeth = try values.decodeIfPresent(Double.self, forKey: .teeth) ?? 0.0
        face = try values.decodeIfPresent(Double.self, forKey: .face) ?? 0.0
    }
    
}
