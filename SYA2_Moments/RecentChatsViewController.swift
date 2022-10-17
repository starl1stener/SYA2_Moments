//
//  RecentChatsViewController.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 30.10.2020.
//  Copyright © 2020 Anton Novoselov. All rights reserved.
//

import UIKit
import FirebaseAuth

class RecentChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func userSignedOut() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print(error)
        }
    }

}
