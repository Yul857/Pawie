//
//  Lost.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/30/21.
//

import Foundation
import Firebase


struct Lost{
    let species: String
    let petName: String
    let breed: String
    let age: String
    let area: String
    let petImageUrl: String
    let description: String
    let ownerName: String
    let phone: String
    let email: String
    let time: Timestamp
    
    
    init(dictionary: [String: Any]) {
        self.species = dictionary["species"] as? String ?? ""
        self.petName = dictionary["petName"] as? String ?? ""
        self.breed = dictionary["breed"] as? String ?? ""
        self.age = dictionary["age"] as? String ?? ""
        self.area = dictionary["area"] as? String ?? ""
        self.petImageUrl = dictionary["petImageURL"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.ownerName = dictionary["ownername"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? "phone unknown"
        self.email = dictionary["email"] as? String ?? "email unknown"
        self.time = dictionary["time"] as? Timestamp ?? Timestamp()
    }
    
}
