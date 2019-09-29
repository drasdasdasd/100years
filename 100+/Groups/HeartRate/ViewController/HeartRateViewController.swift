//
//  HeartRateViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 27/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class HeartRateViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var titleLabel: UILabel!
    
    // - Manager
    private let dataBaseManager = HealthDataBaseManager()
    
    // - Data
    private var heartRateModel = HeartRateDetectionModel()
    private var bpms = [Int]()
    var healthModel: HealthDataModel!
    var isLogin = true

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heartRateModel.delegate = self
        heartRateModel.startDetection()
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        let cameraVC = UIStoryboard(storyboard: .camera).instantiateInitialViewController() as! CameraViewController
        cameraVC.healthModel = healthModel
        cameraVC.isLogin = isLogin
        navigationController?.pushViewController(cameraVC, animated: true)
    }
    
}

// MARK: -
// MARK: -

extension HeartRateViewController: HeartRateDetectionModelDelegate {
    
    func heartRateStart() {
        print("Started")
    }
    
    func heartRateUpdate(_ bpm: Int32, atTime seconds: Int32) {
        var newBPM = bpm
        if bpm > 90 { newBPM -= 15 }
        titleLabel.text = "\(newBPM)\nударов в минуту"
        bpms.append(Int(newBPM))
    }
    
    func heartRateEnd() {
        bpms.removeFirst(0)
        let average = Int(bpms.reduce(0, +) / bpms.count)
        dataBaseManager.update(health: healthModel, bpm: average)
        titleLabel.text = "\(average)\nСредний пульс"
    }
    
}
