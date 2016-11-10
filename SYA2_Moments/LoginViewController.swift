//
//  LoginViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 10/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UITableViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login to Moments"
        
        emailTextField.becomeFirstResponder()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func actionLoginDIdTap() {
        
        if emailTextField.text != ""
            && (passwordTextField.text?.characters.count)! > 6 {
            
            FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (firUser, error) in
                
                if error != nil {
                    self.showAlert(title: "Error", message: "\(error?.localizedDescription)", buttonTitle: "OK")
                } else {
                    print("Login successful")
                    self.dismiss(animated: true, completion: nil)
                }
                
            })
        }
        
        
    }
    
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func actionBackDidTap(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            textField.resignFirstResponder()
            actionLoginDIdTap()
        } else {
            passwordTextField.becomeFirstResponder()
        }
        
        return true
    }
    
    
}

















