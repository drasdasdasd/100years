//
//  DaysView.swift
//  100+
//
//  Created by Dzianis Baidan on 28/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class DaysView: UIView {
    
    // - UI
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // - Data
    private var steps = [StepModel]()
    private var progressHeights = [CGFloat]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func update(steps: [StepModel]) {
        progressHeights.removeAll()
        self.steps = steps
        updateLeftLabel()
        calcSizes()
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: false)
    }
    
    private func calcSizes() {
        let onePercent = CGFloat(FeedConstant.maxDaysCellHeight / 10000.0)
        for step in steps {
            let count = min(step.steps, 10000)
            print("one", CGFloat(count) * onePercent, step.date, step.steps)
            progressHeights.append(CGFloat(count) * onePercent)
        }
    }
    
    private func updateLeftLabel() {
        for step in steps {
            if Calendar.current.isDateInToday(step.date) {
                let left = 10000 - step.steps
                leftLabel.text = "Осталось \(left) шагов"
            }
        }
    }

}

// MARK: -
// MARK: - Collection view data source

extension DaysView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as! DayCollectionViewCell
        cell.set(step: steps[indexPath.row], progressHeight: progressHeights[indexPath.row])
        return cell
    }
    
}

// MARK: -
// MARK: - Collection view data source

extension DaysView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 44, height: FeedConstant.daysCollectionViewSize.height)
    }
    
}

// MARK: -
// MARK: - Configure

private extension DaysView {
    
    func configure() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}
