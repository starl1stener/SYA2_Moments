//
//  ViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 07.10.2021.
//  Copyright © 2021 Anton Novoselov. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
}
