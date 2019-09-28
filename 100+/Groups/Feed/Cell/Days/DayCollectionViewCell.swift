//
//  DayCollectionViewCell.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    // - UI
    @IBOutlet weak var whiteBackgroundView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var checkMarkIconImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    // - Constraint
    @IBOutlet weak var whiteBackgroundViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var whiteViewConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func set(step: StepModel, progressHeight: CGFloat) {
        fillUI(step: step)
        hideNotNeededUI(step: step)
        
        if Calendar.current.isDateInToday(step.date) {
            whiteViewConstraint.constant = max(progressHeight, 50)
            whiteBackgroundViewConstraint.constant = FeedConstant.maxDaysCellHeight
        } else {
            whiteBackgroundViewConstraint.constant = max(progressHeight, 50)
            whiteViewConstraint.constant = 0
        }
    }
    
    func hideNotNeededUI(step: StepModel) {
        let isToday = Calendar.current.isDateInToday(step.date)
        whiteView.isHidden = !isToday
        
        if isToday {
            priceLabel.isHidden = isToday
        }
    }
    
    func fillUI(step: StepModel) {
        dateLabel.text = step.date.ddMM()
        if step.steps >= 10000 {
            checkMarkIconImageView.isHidden = false
            priceLabel.isHidden = true
        } else {
            checkMarkIconImageView.isHidden = true
            priceLabel.isHidden = false
        }
    }
    
}

// MARK: -
// MARK: - Configure

private extension DayCollectionViewCell {
    
    func configure() {}
    
}
