//
//  PostViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/9/21.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var userProfileImageUrl: URL? {return URL(string: post.ownerImageUrl)}
    
    var username: String {return post.ownerUsername}
    
    var caption: String { return post.caption }
    var likes: Int {return post.likes}
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }

    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timeStamp.dateValue(), to: Date())
    }

    var likesLabelText: String {
        if post.likes == 0 {
            return "       "
        }else if post.likes != 1  {
            return "\(post.likes) likes"
        }else{
            return "\(post.likes) like"
        }
    }
    

    
//    var commentsLabelText: String {
//        if post.comments == 0 {
//            return "0 comment"
//        }else if post.comments != 1 {
//            return "\(post.comments) comments"
//        }else{
//            return "\(post.comments) comment"
//        }
//    }
    
    
    init(post: Post){
        self.post = post
    }
}
