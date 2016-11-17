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
        
        static let mediaCell = "MediaCell"
        static let mediaHeaderCell = "MediaHeaderCell"
        
        static let mediaHeaderHeight: CGFloat = 57
        static let mediaCellDefaultHeight: CGFloat = 597
        
        static let showMediaDetailSegue = "ShowMediaDetailSegue"
        
        static let commentCell = "CommentCell"
        static let showCommentComposer = "ShowCommentComposer"
    }
    
    var imagePickerHelper: ImagePickerHelper!
    var currentUser: User?
    var media = [Media]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if the user logged in or not
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            
            if let user = user {
                
                // signed in
                
                DatabaseReference.users(uid: user.uid).reference().observeSingleEvent(of: .value, with: { (snapshot) in
                    if let userDict = snapshot.value as? [String : Any] {
                        self.currentUser = User(dictionary: userDict)
                    }
                })
            } else {
                
                self.performSegue(withIdentifier: Storyboard.showWelcome, sender: nil)
                
            }
        })
        
        self.tabBarController?.delegate = self
        
        tableView.estimatedRowHeight = Storyboard.mediaCellDefaultHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.separatorColor = UIColor.clear
        
        fetchMedia()
    }
    
    
    
    func fetchMedia() {
        
        Media.observeNewMedia { (media) in
            if !self.media.contains(media) {
                self.media.insert(media, at: 0)
                self.tableView.reloadData()
            }
        }
        
    }

    
}


// MARK: - UITableViewDataSource

extension NewsfeedTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return media.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if media.count == 0 {
            return 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.mediaCell, for: indexPath) as! MediaTableViewCell
        cell.currentUser = currentUser
        
        cell.media = media[indexPath.section]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.mediaHeaderCell) as! MediaHeaderCell
        
        cell.currentUser = currentUser
        cell.media = media[section]
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Storyboard.mediaHeaderHeight
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



















