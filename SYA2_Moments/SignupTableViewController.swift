//
//  SignupTableViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit

class SignupTableViewController: UITableViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var imagePickerHelper: ImagePickerHelper!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

       
    }

    @IBAction func actionCreateNewAccountButtonTapped(_ sender: Any) {
        
        // create a new account
        // save the user data, take photo
        // login the user
    }
    
    @IBAction func actionBackTapped(_ sender: Any) {
        
    }
    
    
    @IBAction func actionChangeProfilePhotoDidTap(_ sender: Any) {
        
    }
}












