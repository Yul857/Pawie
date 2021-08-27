//
//  AdoptionViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/26/21.
//

import UIKit
import Firebase

struct AdoptionViewModel {
    var adoption: Adoption
    
    
    var petname: String {
        return adoption.petName
    }
    
    var breed: String {
        return adoption.breed
    }
    
    var age: String {
        return adoption.age
    }
    
    var area: String {
        return adoption.area
    }
    var petImageUrl : URL? {
        return URL(string: adoption.petImageUrl)
    }
    
    var description: String {
        return adoption.description
    }
    
    var phone: String {
        return adoption.phone
    }
    
    var email: String {
        return adoption.email
    }
    var timeStampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: adoption.time.dateValue(), to: Date())
    }
    
    init(adoption: Adoption){
        self.adoption = adoption
    }
}
