//
//  AppDelegate.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        FIRApp.configure()
        
        let dummyUser = User(uid: "123", username: "myUserNameDummy", fullName: "My Dummy User", bio: "My Dummy User", website: "dummy.com", follows: [], followedBy: [], profileImage: UIImage(named: "1"))
        
        dummyUser.save { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
        
        return true
    }

    

}

