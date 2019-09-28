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

}

// MARK: -
// MARK: - Configure

private extension MonthView {
    
    func configure() {
        configureMonth()
    }
    
    func configureMonth() {
        monthLabel.text = Date().MMMM()
    }
    
}
