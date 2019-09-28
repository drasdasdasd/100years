//
//  RiskViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class RiskViewController: UIViewController {
    
    // - Manager
    private let riskServerManager = RiskServerManager()
    
    // - Data
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - Configure

private extension RiskViewController {
    
    func configure() {
        loadPhoto()
    }
    
    func loadPhoto() {
        let imageData = image.jpegData(compressionQuality: 1.0) ?? Data()
        riskServerManager.upload(data: imageData) { (risk, error) in
            // code
        }
    }
    
}
