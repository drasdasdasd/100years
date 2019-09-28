//
//  RiskServerManager.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit
import Moya

class RiskServerManager {
    
    // - Server provider
    private let provider = MoyaProvider<FileDataProvider>()
    
    func upload(data: Data, completion: @escaping ((_ risk: RiskModel?, _ error: String?) -> ())) {
        provider.request(.loadPhoto(data: data)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                
                if statusCode == 200 {
                    if let model = try? JSONDecoder().decode(RiskModel.self, from: data) {
                        completion(model, nil)
                    }
                } else {
                    completion(nil, "Error")
                }
            case .failure:
                completion(nil, "Error")
            }
        }
    }
}
