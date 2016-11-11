//
//  NewsfeedTableViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

class NewsfeedTableViewController: UITableViewController {
    
    struct Storyboard {
        static let showWelcome = "ShowWelcomeViewController"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if the user logged in or not
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
            
            if let user = user {
                
                // signed in
                print("NewsfeedVC: signed in")
                
            } else {
                
                print("NewsfeedVC: not signed in")

                self.performSegue(withIdentifier: Storyboard.showWelcome, sender: nil)
                
            }
        })
        
    }

    
}
