//
//  AdoptionService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/26/21.
//

import Firebase
import UIKit

struct AdoptionCredentials {
    let petName: String
    let breed: String
    let age: String
    let area: String
    let description: String
    let phone: String
    let email: String
    let petImage: UIImage
    let time: Timestamp
}

struct AdoptionService {
    static func uploadAdoption(withCredentials credentials: AdoptionCredentials, completion: @escaping(Error?)-> Void) {
        ImageUploader.uploadImage(image: credentials.petImage) { imageURL in
            
            let data: [String: Any] = ["petName" : credentials.petName, "breed": credentials.breed,
                                       "age": credentials.age, "area": credentials.area,
                                       "petImageURL": imageURL, "description": credentials.description,
                                       "phone": credentials.phone, "email": credentials.email,
                                       "time": credentials.time]
            
            COLLECTION_ADOPTIONS.addDocument(data: data, completion: completion)
            
        }
    }
    
    static func fetchAdoption(completion: @escaping([Adoption]) -> Void) {
        COLLECTION_ADOPTIONS.order(by: "time", descending: true).getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {return}
            
            let adoptions = snapshot.documents.map({Adoption(dictionary: $0.data())})
            
            completion(adoptions)
        }
    }
}
