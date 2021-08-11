//
//  Comment.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/10/21.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timeStamp: Timestamp
    let commentText: String
    
    
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}

