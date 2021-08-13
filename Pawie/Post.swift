//
//  Post.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/9/21.
//

import Foundation
import Firebase

struct Post{
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timeStamp: Timestamp
    let postID: String
    let ownerImageUrl: String
    let ownerUsername: String

    
    var didLike = false
    
    init(postID: String, dictionary: [String: Any]) {
        self.postID = postID
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageURL"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
    
}
