//
//  UIViewControllerExtension.swift
//  100+
//
//  Created by Dzianis Baidan on 29/09/2019.
//  Copyright © 2019 DB. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithTitle(_ title: String?, message: String?, okButtonClosure: ((_ action: UIAlertAction?) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let okButtonClosure = okButtonClosure {
            alert.addAction(UIAlertAction(title: "Хорошо", style: .destructive, handler: okButtonClosure))
        }
        showAlert(alert)
    }
    
    func showAlert(_ alert: UIAlertController) {
        guard self.presentedViewController != nil else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
}
