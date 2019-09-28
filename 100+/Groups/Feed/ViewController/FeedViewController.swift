//
//  FeedViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    // - UI
    @IBOutlet weak var daysView: DaysView!
    
    // - Manager
    private let healthKitManager = HealthKitManager()
    private let pointsManager = PointsManager()
    
    // - Data
    private var steps = [StepModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - Configure

private extension FeedViewController {
    
    func configure() {
        getSteps()
    }
    
    func getSteps() {
        healthKitManager.authorize { [weak self] (finished, error) in
            self?.pointsManager.getSteps(completion: { (steps) in
                self?.steps = steps.sorted(by: { $0.date > $1.date })
                self?.daysView.update(steps: steps.sorted(by: { $0.date > $1.date }))
            })
        }
    }
    
}
