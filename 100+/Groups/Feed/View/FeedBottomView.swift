//
//  FeedBottomView.swift
//  100+
//
//  Created by Dzianis Baidan on 29/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class FeedBottomView: UIView {
    
    // - UI
    private let gradient = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }

}

// MARK: -
// MARK: - Configure

private extension FeedBottomView {
    
    func configure() {
        addGradient()
    }
    
    func addGradient() {
        gradient.frame = bounds
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
}
