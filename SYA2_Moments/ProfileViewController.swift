//
//  ProfileViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 10/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    @IBAction func actionLogOutDidTap(_ sender: Any) {
        
        try! FIRAuth.auth()?.signOut()
        
        self.tabBarController?.selectedIndex = 0
        
    }

}
