//
//  PollViewController.swift
//  100+
//
//  Created by Dzianis Baidan on 27/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

class PollViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var switchers: [UISegmentedControl]!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var sexSwitcher: UISegmentedControl!
    @IBOutlet weak var smokeSwitcher: UISegmentedControl!
    @IBOutlet weak var strokeTextField: UISegmentedControl!
    
    // - Manager
    private let healthKitManager = HealthKitManager()
    
    // - Data
    private let healthModel = HealthDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if updateNextButton() {
            let heartRateVC = UIStoryboard(storyboard: .heartRate).instantiateInitialViewController() as! HeartRateViewController
            heartRateVC.healthModel = healthModel
            navigationController?.pushViewController(heartRateVC, animated: true)
        }
    }
    
    @IBAction func getFromHealthKitButtonAction(_ sender: Any) {
        healthKitManager.authorize { (finished, error) in
        }
    }
    
    @IBAction func switchDidChanged(_ sender: UISegmentedControl) {
        let currentIndex = switchers.firstIndex(of: sender) ?? 0
        switch currentIndex {
        case 0:
            healthModel.sex = sender.selectedSegmentIndex
        case 1:
            healthModel.smoking = sender.selectedSegmentIndex
        case 2:
            healthModel.relativeStroke = sender.selectedSegmentIndex
        default: break
        }
        view.endEditing(true)
        let _ = updateNextButton()
    }
    
}

// MARK: -
// MARK: - Configure

private extension PollViewController {
    
    func configure() {
        configureNotifications()
        configureTextFields()
    }
    
    func configureNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    func configureTextFields() {
        for textField in textFields {
            textField.delegate = self
        }
    }
    
}

// MARK: -
// MARK: - Text field delegate

extension PollViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return true }
        let updatedText = text.replacingCharacters(in: range, with: string).replacingOccurrences(of: ",", with: ".")
        let value = Double(updatedText) ?? 0
        let currentIndex = textFields.firstIndex(of: textField) ?? 0
        
        switch currentIndex {
        case 0:
            healthModel.height = value
        case 1:
            healthModel.weight = value
        case 2:
            healthModel.age = Int(value)
        default: break
        }
        
        let _ = updateNextButton()
        return true
    }

}

// MARK: -
// MARK: - Update

extension PollViewController {
    
    func updateNextButton() -> Bool {
        if healthModel.age > 0 && healthModel.height > 0 && healthModel.weight > 0 && healthModel.sex >= 0 && healthModel.smoking >= 0 && healthModel.relativeStroke >= 0 {
            nextButton.backgroundColor = AppColor.color(fromHex: "1A00FF")
            nextButton.setTitleColor(UIColor.white, for: .normal)
            return true
        }
        return false
    }
    
}
