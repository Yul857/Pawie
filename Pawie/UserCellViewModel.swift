//
//  UserCellViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/8/21.
//

import Foundation


struct UserCellViewModel{
    private var user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var username: String {
        return user.userName
    }
    
    var petname: String {
        return user.petname
    }
    
    init(user: User){
        self.user = user
    }
}
