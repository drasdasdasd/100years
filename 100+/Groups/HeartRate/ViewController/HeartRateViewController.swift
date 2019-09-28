//
//  HeartRateViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 27/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class HeartRateViewController: UIViewController {
    
    // - Data
    private var heartRateModel = HeartRateDetectionModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        heartRateModel.delegate = self
        heartRateModel.startDetection()
    }

}

// MARK: -
// MARK: -

extension HeartRateViewController: HeartRateDetectionModelDelegate {
    
    func heartRateStart() {
        print("Started")
    }
    
    func heartRateUpdate(_ bpm: Int32, atTime seconds: Int32) {
        print(bpm)
    }
    
    func heartRateEnd() {
        print("end")
    }
    
}
