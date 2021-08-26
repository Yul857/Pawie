//
//  Constants.swift
//  Pawie
//
//  Created by Yu Ming Lin on 8/7/21.
//

import Firebase


let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")

let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")

let COLLECTION_CONSULTS = Firestore.firestore().collection("consults")
