//
//  AuthenticationViewModel.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/6/21.
//

import UIKit

protocol formViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool {get}
    var buttonBackgroundColor: UIColor {get}
    var buttonTitleColor: UIColor {get}
}

struct LoginViewModel: AuthenticationViewModel{
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor{
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}


struct RegistrationViewModel: AuthenticationViewModel{

    var email: String?
    var password: String?
    var ownername: String?
    var petname : String?
    var username: String?
    var bio: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && ownername?.isEmpty == false && petname?.isEmpty == false && username?.isEmpty == false && bio?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
        
    }
}
