//
//  ProfileHeaderViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/8/21.
//

import UIKit


struct ProfileHeaderViewModel {
    let user: User
    
    var petname: String {
        return user.petname
    }
    
    var ownername: String {
        return user.ownername
    }
    
    var profileImageUrl: URL?{
        return URL(string: user.profileImageURL)
    }
    
    var bio: String {
        return user.bio
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }

        return user.isFollowed ? "Following" : "Follow"
    }

    var followButtonBackgoundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }

    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }

    var numberOfFollowers: NSAttributedString {
        return attributedStackText(value: user.stats.followers, label: "followers")
    }

    var numberOfFollowing: NSAttributedString {
        return attributedStackText(value: user.stats.following, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStackText(value: user.stats.posts, label: "posts")
    }
    
    init(user: User){
        self.user = user
    }
    
    func attributedStackText(value: Int, label: String) -> NSAttributedString{
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
}
