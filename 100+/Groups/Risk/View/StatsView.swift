//
//  StatsView.swift
//  100+
//
//  Created by Dzianis Baidan on 29/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class StatsView: UIView {

    // - UI
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var strokeLabel: UILabel!
    private var shapeLayer: CAShapeLayer!
    private var trackLayer: CAShapeLayer!
    
    // - Data
    private let color = AppColor.color(fromHex: "000000")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        trackLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
    }
    
    func update(title: String, text: String, color: UIColor, index: Int) {
        let percents = CGFloat(index * 10) / CGFloat(100)
        shapeLayer.strokeEnd = CGFloat(percents)
        shapeLayer.strokeColor = color.cgColor
        indexLabel.textColor = color
        indexLabel.text = "\(index) из 10"
    }
    
}

// MARK: -
// MARK: - Configure

private extension StatsView {
    
    func createCircleShapeLayer(strokeColor: UIColor, fillColor: UIColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.lineCap = CAShapeLayerLineCap.round
        return layer
    }
    
    func setupCircleLayers() {
        trackLayer = createCircleShapeLayer(strokeColor: AppColor.color(fromHex: "F7F7F7"), fillColor: .white)
        layer.insertSublayer(trackLayer, at: 0)
        
        shapeLayer = createCircleShapeLayer(strokeColor: color, fillColor: .clear)
        
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer.strokeEnd = 0
        layer.insertSublayer(shapeLayer, at: 1)
    }
    
}

// MARK: -
// MARK: - Configure

private extension StatsView {
    
    func configure() {
        setupCircleLayers()
    }
    
}
