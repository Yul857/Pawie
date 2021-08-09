//
//  User.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/8/21.
//

import Foundation
import Firebase


struct User {
    let email: String
    let ownername: String
    let profileImageURL: String
    let petname: String
    let bio: String
    let userName: String
    let uid: String
    
    var isFollowed = false
    
    //var stats: UserStats!
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == uid}
    
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.ownername = dictionary["ownername"] as? String ?? ""
        self.bio = dictionary["bio"] as? String ?? ""
        self.petname = dictionary["petname"] as? String ?? ""
        self.profileImageURL = dictionary["profileImageUrl"] as? String ?? ""
        self.userName = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
        //self.stats = UserStats(followers: 0, following: 0, posts: 0)
    }
    
}
