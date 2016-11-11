//
//  Media.swift
//  SYA2_Moments
//
//  Created by nag on 11/11/2016.
//  Copyright © 2016 Anton Novoselov. All rights reserved.
//

import UIKit
import Firebase

class Media {
    
    var uid: String
    let type: String // "image" or "video"
    var caption: String
    var createdTime: Double
    var createdBy: User
    var likes: [User]
    var comments: [Comment]
    var mediaImage: UIImage!
    
    
    init(type: String, caption: String, createdBy: User, image: UIImage) {
        self.type = type
        self.createdBy = createdBy
        self.mediaImage = image
        self.caption = caption
        
        createdTime = Date().timeIntervalSince1970 // number of seconds from 1970
        
        comments = []
        likes = []
        uid = DatabaseReference.media.reference().childByAutoId().key
        
        
    }
    
    
    func save(completion: @escaping (Error?) -> Void) {
        let ref = DatabaseReference.media.reference().child(uid)
        ref.setValue(toDictionary())
        
        // Save Likes
        
        for likeUser in likes {
            ref.child("likes/\(likeUser.uid)").setValue(likeUser.toDictionary())
        }
        
        // Save Comments
        
        for comment in comments {
            ref.child("comments/\(comment.uid)").setValue(comment.toDictionary())
        }
        
        
        // Upload image to storage
        
        let firImage = FIRImage(image: mediaImage)
        
        firImage.save(self.uid, completion: { (error) in
            
            completion(error)
        })
        
        
    }
    
    func toDictionary() -> [String: Any] {
        
        return [
            
            "uid":          uid,
            "type":         type,
            "createdTime":  createdTime,
            "createdBy":    createdBy.toDictionary(),
            "caption":      caption
            
        ]
        
        
    }
    
    
    
}


extension Media {
    
    func downloadMediaImage(completion: @escaping (UIImage?, Error?) -> Void) {
        
        FIRImage.downloadImage(uid, completion: {
            (image, error) in
            
            completion(image,error)
        
        
        
        })
        
        
    }

}




class Comment {
    
    var mediaUID: String
    var uid: String
    
    var createdTime: Double
    var from: User
    
    var caption: String
    var ref: FIRDatabaseReference
    
    init(mediaUID: String, from: User, caption: String) {
        self.mediaUID = mediaUID
        self.from = from
        self.caption = caption
        
        self.createdTime = Date().timeIntervalSince1970
        
        ref = DatabaseReference.media.reference().child("\(mediaUID)/comments").childByAutoId()
        
        uid = ref.key
    }
    
    
    init(dictionary: [String: Any]) {
        
        uid = dictionary["uid"] as! String
        mediaUID = dictionary["mediaUID"] as! String
        createdTime = dictionary["createdTime"] as! Double
        caption = dictionary["caption"] as! String
        
        let userDict = dictionary["from"] as! [String: Any]
        from = User(dictionary: userDict)
        
        
        ref = DatabaseReference.media.reference().child("\(mediaUID)/comments/\(uid)")
        
    }
    
    
    func save() {
        ref.setValue(toDictionary())
    }
    
    
    func toDictionary() -> [String: Any] {
        
        return [
            
            "mediaUID":     mediaUID,
            "uid":          uid,
            "createdTime":  createdTime,
            "from":         from.toDictionary(),
            "caption":      caption
            
        ]
        
        
    }
    
}
























