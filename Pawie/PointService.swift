//
//  PointService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 9/1/21.
//

import Firebase
import UIKit

struct PointCredentials{
    let points: Int
    let time: Timestamp
}

struct PointService {
    static func addPoints(with credentials: PointCredentials, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let data: [String: Any] = ["points": credentials.points, "time": credentials.time]
        
        COLLECTION_POINT.document(uid).collection("gift").addDocument(data: data, completion: completion)
    }
    static func fetchPoints(completion: @escaping([Point]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        COLLECTION_POINT.document(uid).collection("gift").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let points = snapshot.documents.map({Point(dictionary: $0.data())})
            
            completion(points)
        }
    }
}
