//
//  FoundViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/30/21.
//

import UIKit
import Firebase

struct FoundViewModel {
    var found: Found
    
    var species: String {
        return found.species
    }
    
    var ownerName: String {
        return found.ownerName
    }
    
    
    var petname: String {
        return found.petName
    }
    
    var breed: String {
        return found.breed
    }
    
    var area: String {
        return found.area
    }
    var petImageUrl : URL? {
        return URL(string: found.petImageUrl)
    }
    
    var description: String {
        return found.description
    }
    
    var phone: String {
        return found.phone
    }
    
    var email: String {
        return found.email
    }
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: found.time.dateValue(), to: Date())
    }
    
    init(found: Found){
        self.found = found
    }
}
