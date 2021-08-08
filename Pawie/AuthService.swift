//
//  AuthService.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/7/21.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    static func LogUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping(Error?)-> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (results, error) in
                if let error = error{
                    print("DEBUG: Failed to register User, \(error)")
                    return
                }
                guard let uid = results?.user.uid else {return}
                
                let data: [String: Any] = ["email" : credentials.email, "fullname": credentials.fullname,
                                           "profileImageUrl": imageURL, "uid": uid, "username": credentials.username]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            
            }
        }
    }
}
