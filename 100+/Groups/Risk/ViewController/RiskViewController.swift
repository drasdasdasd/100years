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
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var statsView: StatsView!
    
    // - Manager
    private let riskServerManager = RiskServerManager()
    
    // - Data
    var image: UIImage!
    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: - Configure

private extension RiskViewController {
    
    func configure() {
        // configureImageView()
        // loadPhoto()
        fillStatsView()
    }
    
    func configureImageView() {
        photoImageView.image = image
    }
    
    func loadPhoto() {
        let imageData = image.jpegData(compressionQuality: 1.0) ?? Data()
        riskServerManager.upload(data: imageData) { (risk, error) in
            if let risk = risk {
                // dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func fillStatsView() {
        statsView.update(title: Const.titles[index], text: Const.textes[index], color: Const.colors[index], index: index + 1)
    }
    
}

// MARK: -
// MARK: - Const

private extension RiskViewController {
    
    enum Const {
        static let titles = ["Все хорошо", "Лучше сходите к врачу", "Срочно к врачу!"]
        static let textes = ["Ведите здоровый образ жизни", "Проверьте свое здоровье в клинике", "Вам нужно вести здоровый образ жизни и регулярно проверять свое здоровье"]
        static let colors = [AppColor.color(fromHex: "40C17B"), AppColor.color(fromHex: "FF9B04"), AppColor.color(fromHex: "FF2E00")]
    }
    
}
