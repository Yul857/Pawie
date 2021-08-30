//
//  LostService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/30/21.
//

import Firebase
import UIKit

struct LostCredentials {
    let species: String
    let petName: String
    let breed: String
    let age: String
    let area: String
    let description: String
    let phone: String
    let email: String
    let ownerName: String
    let petImage: UIImage
    let time: Timestamp
}

struct LostService {
    static func uploadLosts(withCredentials credentials: LostCredentials, completion: @escaping(Error?)-> Void) {
        ImageUploader.uploadImage(image: credentials.petImage) { imageURL in
            
            let data: [String: Any] = ["petName" : credentials.petName, "breed": credentials.breed,
                                       "age": credentials.age, "area": credentials.area,
                                       "petImageURL": imageURL, "description": credentials.description,
                                       "phone": credentials.phone, "email": credentials.email,
                                       "time": credentials.time, "species": credentials.species,
                                       "ownername": credentials.ownerName]
            
            COLLECTION_LOST.addDocument(data: data, completion: completion)
            
        }
    }
    
    static func fetchLosts(completion: @escaping([Lost]) -> Void) {
        COLLECTION_LOST.order(by: "time", descending: true).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let losts = snapshot.documents.map({Lost(dictionary: $0.data())})
            
            completion(losts)
        }
    }
}
