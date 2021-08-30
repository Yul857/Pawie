//
//  LostViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/30/21.
//

import UIKit
import Firebase

struct LostViewModel {
    var lost: Lost
    
    var species: String {
        return lost.species
    }
    
    var ownerName: String {
        return lost.ownerName
    }
    
    
    var petname: String {
        return lost.petName
    }
    
    var breed: String {
        return lost.breed
    }
    
    var age: String {
        return lost.age
    }
    
    var area: String {
        return lost.area
    }
    var petImageUrl : URL? {
        return URL(string: lost.petImageUrl)
    }
    
    var description: String {
        return lost.description
    }
    
    var phone: String {
        return lost.phone
    }
    
    var email: String {
        return lost.email
    }
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: lost.time.dateValue(), to: Date())
    }
    
    init(lost: Lost){
        self.lost = lost
    }
}
