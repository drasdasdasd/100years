//
//  MonthView.swift
//  100+
//
//  Created by Dzianis Baidan on 29/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class MonthView: UIView {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var statsView: StatsSmallView!
    
    // - 1
    @IBOutlet weak var bpmLabel: UILabel!
    
    // - 2
    @IBOutlet weak var photoProblem: UILabel!
    @IBOutlet weak var photoProblemDescription: UILabel!
    
    // - 3
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var stepsDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    func update(health: HealthDataModel, steps: Int) {
        bpmLabel.text = "\(health.bpm) ударов в минуту"
        
        // - статистика
        statsView.update(title: health.title, text: health.title, color: AppColor.color(fromHex: health.color), index: health.index)
        
        // - лицо
        if health.face < 30 {
            photoProblem.text = "Проблем нет"
            photoProblemDescription.text = "Покраснений нет"
        } else {
            photoProblem.text = "Есть проблемы"
            photoProblemDescription.text = "Есть покраснения"
        }
        
        if health.teeth > 20 {
            let text = photoProblemDescription.text ?? ""
            photoProblemDescription.text = text + ", есть налет на зубах"
        }
        
        // - Шаги
        stepsLabel.text = "Пройдено \(steps) шагов"
        
        let targetSteps = Date().daysInMonth() * 10000
        
        if targetSteps > steps {
            stepsDescriptionLabel.text = "Осталось \(targetSteps - steps) шагов"
        } else {
            stepsDescriptionLabel.text = "Цель выполнена!"
        }
    }
    
}

// MARK: -
// MARK: - Configure

private extension MonthView {
    
    func configure() {
        configureMonth()
    }
    
    func configureMonth() {
        monthLabel.text = "Сентябрь"
        // monthLabel.text = Date().MMMM()
    }
    
}
