//
//  ConsultService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/25/21.
//

import Firebase
import MessageKit

struct ChatUser: SenderType {
    var senderId: String
    var displayName: String
}

struct ConsultService {
    static func uploadMessages(message: Message,
                               completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data: [String: Any] = ["content": message.content,
                                   "created": message.created,
                                   "id": message.id,
                                   "senderID": message.senderID,
                                   "senderName": message.senderName]
        COLLECTION_CONSULTS.document(uid).collection("messages").addDocument(data: data, completion: completion)
        

    }
    
    static func loadMessages(completion: @escaping([Message]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        var messages = [Message]()
        
        let query = COLLECTION_CONSULTS.document(uid).collection("messages").order(by: "created", descending: false)
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    if let message = Message(dictionary: data){
                        messages.append(message)
                    }
                }
            })
            completion(messages)
        }
    }
}
