//
//  FileServerManager.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import Foundation
import Moya

enum FileDataProvider: TargetType {
    
    case loadPhoto(data: Data)
    
    var baseURL: URL {
        return URL(string: "http://51.158.185.47:5000/")!
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var path: String {
        switch self {
        case .loadPhoto:
            return "uploader"
        }
    }
    
    var task: Task {
        switch self {
        case .loadPhoto(let data):
            let formData: [MultipartFormData] = [MultipartFormData(
                provider: .data(data),
                name: "file",
                fileName: "image.jpg",
                mimeType: "image/jpeg")]
            
            return .uploadCompositeMultipart(formData, urlParameters: [:])
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
}

