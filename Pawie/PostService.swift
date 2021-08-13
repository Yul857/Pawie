//
//  PostService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/9/21.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        ImageUploader.uploadImage(image: image) { imageURL in
            let data = ["caption": caption,
                        "timeStamp": Timestamp(date: Date()),
                        "likes": 0,"imageURL": imageURL,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageURL,
                        "ownerUsername": user.userName] as [String: Any]
            
            
            
            let docRef = COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
            updateUserFeedAfterPost(postId: docRef.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timeStamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
        
            let posts = documents.map({Post(postID: $0.documentID, dictionary: $0.data()) })
            completion(posts)
            }
            
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {return}
        
            var posts = documents.map({Post(postID: $0.documentID, dictionary: $0.data()) })
            posts.sort { (post1, post2) -> Bool in
                return post1.timeStamp.seconds > post2.timeStamp.seconds
            }
            completion(posts)
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post) -> Void) {
        COLLECTION_POSTS.document(postId).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data() else { return}
            let post = Post(postID: snapshot.documentID, dictionary: data)
            
            completion(post)
        }
        
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        COLLECTION_POSTS.document(post.postID).updateData(["likes": post.likes + 1])
        COLLECTION_POSTS.document(post.postID).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard post.likes > 0 else {return}
        
        COLLECTION_POSTS.document(post.postID).updateData(["likes": post.likes - 1])
        
        COLLECTION_POSTS.document(post.postID).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postID).getDocument { (snapshot, _) in
            guard let didLike = snapshot?.exists else {return}
            completion(didLike)
        }
    }
    
    static func fetchFeedPosts(completion: @escaping([Post]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var posts = [Post]()
        COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                fetchPost(withPostId: document.documentID) { post in
                    posts.append(post)
                    posts.sort { (post1, post2) -> Bool in
                        return post1.timeStamp.seconds > post2.timeStamp.seconds
                    }
                    completion(posts)
                }
            })
        }
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return}
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let docIDs = documents.map({$0.documentID})
            docIDs.forEach { id in
                if didFollow {
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).setData([:])
                }else{
                    COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
            }
        }
    }
    
    private static func updateUserFeedAfterPost(postId: String) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            documents.forEach { document in
                COLLECTION_USERS.document(document.documentID).collection("user-feed").document(postId).setData([:])
            }
            COLLECTION_USERS.document(uid).collection("user-feed").document(postId).setData([:])
        }
    }
    
    static func fetchCommentsNumber(post: Post, completion: @escaping(Int) -> Void) {
        COLLECTION_POSTS.document(post.postID).collection("comments").getDocuments { snapshot, error in
            if let error = error {
                print("There is an error fetching comment count, \(error)")
                return
            }
            let counts = snapshot?.documents.count
            
            completion(counts ?? 0)
        }
    }
    
}
