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
    @IBOutlet weak var monthView: MonthView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    // - Manager
    private let healthKitManager = HealthKitManager()
    private let pointsManager = PointsManager()
    
    // - Data
    private var steps = [StepModel]()
    private var healthModel = HealthDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func startAnalizeAction(_ sender: Any) {
        let heartRateVC = UIStoryboard(storyboard: .heartRate).instantiateInitialViewController() as! HeartRateViewController
        heartRateVC.isLogin = false
        heartRateVC.healthModel = healthModel
        navigationController?.pushViewController(heartRateVC, animated: true)
    }
    
    @IBAction func switcherChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            daysView.isHidden = false
            monthView.isHidden = true
            headerView.backgroundColor = AppColor.color(fromHex: "00AC4F")
            tableView.backgroundColor = AppColor.color(fromHex: "00AC4F")
            footerView.backgroundColor = AppColor.color(fromHex: "00AC4F")
        } else {
            daysView.isHidden = true
            monthView.isHidden = false
            headerView.backgroundColor = AppColor.color(fromHex: "5A48C0")
            tableView.backgroundColor = AppColor.color(fromHex: "5A48C0")
            footerView.backgroundColor = AppColor.color(fromHex: "5A48C0")
        }
    }
    
}

// MARK: -
// MARK: - Configure

private extension FeedViewController {
    
    func configure() {
        getSteps()
        getHealthModel()
    }
    
    func getHealthModel() {
        healthModel = HealthDataBaseManager().healthModel ?? HealthDataModel()
        pointsManager.getMonthSteps { [weak self] (steps) in
            guard let strongSelf = self else { return }
            strongSelf.monthView.update(health: strongSelf.healthModel, steps: Int(steps))
        }
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
