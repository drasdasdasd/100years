//
//  RiskViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class RiskViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var statsView: StatsView!
    
    // - Manager
    private let riskServerManager = RiskServerManager()
    private let healthDataBase = HealthDataBaseManager()
    
    // - Data
    var image: UIImage!
    var healthModel: HealthDataModel!
    var isLogin = true
    private var index = 0
    private var riskModel: RiskModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func nextButtonAction(_ sender: Any) {
        if isLogin {
            let feedVC = UIStoryboard(storyboard: .feed).instantiateInitialViewController() as! FeedViewController
            let nVC = UINavigationController(rootViewController: feedVC)
            nVC.setNavigationBarHidden(true, animated: false)
            present(nVC, animated: true, completion: nil)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: -
// MARK: - Configure

private extension RiskViewController {
    
    func configure() {
        hideAllUI(hide: true)
        configureImageView()
        loadPhoto()
    }
    
    func configureImageView() {
        photoImageView.image = image
    }
    
    func loadPhoto() {
        let imageData = image.jpegData(compressionQuality: 1.0) ?? Data()
        riskServerManager.upload(data: imageData) { [weak self] (risk, error) in
            if let risk = risk {
                self?.riskModel = risk
                self?.calcRisk()
                self?.fillStatsView()
                self?.hideAllUI(hide: false)
            } else {
                self?.showProblemAlert()
            }
        }
    }
    
    func fillStatsView() {
        statsView.update(
            title: Const.titles[index],
            text: Const.textes[index],
            color: AppColor.color(fromHex: Const.colors[index]),
            index: healthModel.index)
    }
    
    func hideAllUI(hide: Bool) {
        for subview in view.subviews {
            subview.isHidden = hide
        }
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = !hide
        loadingLabel.isHidden = !hide
    }
    
}

// MARK: -
// MARK: - Const

private extension RiskViewController {
    
    func calcRisk() {
        var risk = 0
        
        // - Есть родственник
        if healthModel.relativeStroke == 0 {
            risk += 20
        }
        
        // - Пол
        if healthModel.sex == 0 {
            risk += 5
        }
        
        // - Пульс
        if healthModel.bpm > 100 {
            risk += 10
        }
        
        // - Шаги
        if healthModel.steps <= 1000 {
            risk += 9
        } else if healthModel.steps <= 2000 {
            risk += 8
        } else if healthModel.steps <= 3000 {
            risk += 7
        } else if healthModel.steps <= 4000 {
            risk += 6
        } else if healthModel.steps <= 5000 {
            risk += 5
        } else if healthModel.steps <= 6000 {
            risk += 4
        } else if healthModel.steps <= 7000 {
            risk += 3
        } else if healthModel.steps <= 8000 {
            risk += 2
        } else if healthModel.steps <= 9000 {
            risk += 1
        }
        
        // - ИМТ
        let imt = healthModel.weight / ((healthModel.height / 100) * (healthModel.height / 100))
        if imt >= 30 && imt <= 35 {
            risk += 5
        } else if imt > 35 && imt <= 39 {
            risk += 10
        } else if imt > 39 {
            risk += 15
        }
        
        // - Покраснения лица
        if riskModel.face >= 60 {
            risk += 10
        } else if riskModel.face > 30 {
            risk += 5
        } else if riskModel.face > 10 {
            risk += 2
        }
        
        // - Курение
        if healthModel.smoking == 0 && riskModel.teeth > 30 {
            risk += 10
        }
        
        // - Проверка верхних границ
        if risk >= 100 {
            risk -= 10
        }
        
        let riskTo10 = risk / 10
        
        var localIndex = 0
        if riskTo10 < 4 {
            localIndex = 0
        } else if riskTo10 < 7 {
            localIndex = 1
        } else {
            localIndex = 2
        }
        
        index = localIndex
        
        try? healthDataBase.realm.write { [weak self] in
            self?.healthModel.index = riskTo10
            self?.healthModel.title = Const.titles[localIndex]
            self?.healthModel.color = Const.colors[localIndex]
            
            self?.healthModel.teeth = Int(riskModel.teeth)
            self?.healthModel.face = Int(riskModel.face)
        }
        
        healthDataBase.save(healthModel: healthModel)
    }
    
    enum Const {
        static let titles = ["Все хорошо", "Лучше сходите к врачу", "Срочно к врачу!"]
        static let textes = ["Ведите здоровый образ жизни", "Проверьте свое здоровье в клинике", "Вам нужно вести здоровый образ жизни и регулярно проверять свое здоровье"]
        static let colors = ["40C17B", "FF9B04", "FF2E00"]
    }
    
}

// MARK: -
// MARK: - Show logic

private extension RiskViewController {
    
    func showProblemAlert() {
        let alert = UIAlertController(title: "Ошибка", message: "Пожалуйста, попробуйте еще раз.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
    
}
