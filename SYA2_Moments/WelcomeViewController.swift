//
//  WelcomeViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.dismiss(animated: false, completion: nil)
            } else {
                
            }
        })

        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
