//
//  CommentService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/10/21.
//
import Firebase

struct CommentService {
    static func uploadComments(comment: String, postID: String, user: User,
                               completion: @escaping(FirestoreCompletion)) {
        let data: [String: Any] = ["uid": user.uid, "comment": comment,
                                   "timeStamp": Timestamp(date: Date()),
                                   "username": user.userName,
                                   "profileImageUrl": user.profileImageURL]
        
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComments(forPost postID: String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timeStamp", descending: true)
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
    }
}
