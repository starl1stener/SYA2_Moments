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
        static let postComposerNVC = "PostComposerNavigationVC"
    }
    
    var imagePickerHelper: ImagePickerHelper!
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if the user logged in or not
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                
                // signed in
                print("NewsfeedVC: signed in")
                
                DatabaseReference.users(uid: user.uid).reference().observeSingleEvent(of: .value, with: { (snapshot) in
                    if let userDict = snapshot.value as? [String : Any] {
                        self.currentUser = User(dictionary: userDict)
                    }
                })
            } else {
                
                print("NewsfeedVC: not signed in")

                self.performSegue(withIdentifier: Storyboard.showWelcome, sender: nil)
                
            }
        })
        
        self.tabBarController?.delegate = self
        
        
    }

    
}



extension NewsfeedTableViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if let _ = viewController as? DummyPostComposerViewController {
            
            imagePickerHelper = ImagePickerHelper(viewController: self, completion: { (image) in
                
                let postComposerNVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Storyboard.postComposerNVC) as! UINavigationController
                
                let postComposerVC = postComposerNVC.topViewController as! PostComposerViewController
                
                postComposerVC.image = image
                
                self.present(postComposerNVC, animated: true, completion: nil)
                
            })
            
            return false
        }
        
        return true
        
    }
    
}



















