//
//  FoundService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/30/21.
//

import Firebase
import UIKit

struct FoundCredentials {
    let species: String
    let petName: String
    let breed: String
    let area: String
    let description: String
    let phone: String
    let email: String
    let ownerName: String
    let petImage: UIImage
    let time: Timestamp
}

struct FoundService {
    static func uploadFounds(withCredentials credentials: FoundCredentials, completion: @escaping(Error?)-> Void) {
        ImageUploader.uploadImage(image: credentials.petImage) { imageURL in
            
            let data: [String: Any] = ["petName" : credentials.petName, "breed": credentials.breed,
                                       "area": credentials.area, "ownername": credentials.ownerName,
                                       "petImageURL": imageURL, "description": credentials.description,
                                       "phone": credentials.phone, "email": credentials.email,
                                       "time": credentials.time, "species": credentials.species,
                                       ]
            
            COLLECTION_FOUND.addDocument(data: data, completion: completion)
            
        }
    }
    
    static func fetchFounds(completion: @escaping([Found]) -> Void) {
        COLLECTION_FOUND.order(by: "time", descending: true).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let founds = snapshot.documents.map({Found(dictionary: $0.data())})
            
            completion(founds)
        }
    }
}
