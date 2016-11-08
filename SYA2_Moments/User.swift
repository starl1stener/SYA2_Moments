//
//  User.swift
//  SYA2_Moments
//
//  Created by Anton Novoselov on 08/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import Foundation
import Firebase

class User {
    
    let uid: String
    let username: String
    let fullName: String
    let bio: String
    let website: String
    
    let profileImage: UIImage?
    var follows: [User]
    var followedBy: [User]
    
    // MARK: - Initializers
    
    init(uid: String, username: String, fullName: String, bio: String, website: String, follows: [User], followedBy: [User], profileImage: UIImage?) {
        
        self.uid = uid
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.website = website
        
        self.follows  = follows
        self.followedBy = followedBy
        
        self.profileImage = profileImage
        
    }
    
    func save() {
        // 1
        let ref = DatabaseReference.users(uid: uid).reference()
        ref.setValue(toDictionary())
        
        // 2 - save follows
        for followUser in follows {
            ref.child("follows/\(followUser.uid)").setValue(followUser.toDictionary())
        }
        
        // 3 - save followed by
        for followedUser in followedBy {
            ref.child("followedBy/\(followedUser.uid)").setValue(followedUser.toDictionary())
        }
        
        // 4 - save the profile image
        
        
    }
    
    
    
    func toDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "username": username,
            "fullName": fullName,
            "bio": bio,
            "website": website
        ]
    }
}



