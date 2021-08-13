//
//  NotificationService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/11/21.

import Firebase


struct NotificationService {
    
    static func uploadNotification(toUid uid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        
        guard let currentuid = Auth.auth().currentUser?.uid else {return}
        guard uid != currentuid else {return}
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timeStamp": Timestamp(date: Date()), "uid": fromUser.uid,
                                   "type": type.rawValue, "id": docRef.documentID,
                                   "userProfileImageUrl": fromUser.profileImageURL,
                                   "username": fromUser.userName]
        if let post = post {
            data["postId"] = post.postID
            data["postImageUrl"] = post.imageUrl
        }
        docRef.setData(data)
        
    }
    
    static func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").order(by: "timeStamp", descending: true)
        
        query.getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else {return}
            let notifications = documents.map({Notification(dictionary: $0.data())})
            completion(notifications)
        }
        
    }
}
