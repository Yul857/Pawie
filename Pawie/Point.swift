//
//  Point.swift
//  Pawie
//
//  Created by Yu Ming Lin on 9/1/21.
//


import Foundation
import Firebase


struct Point{
    let point: Int
    let time: Timestamp
    
    init(dictionary: [String: Any]) {
        self.point =  dictionary["points"] as? Int ?? 0
        self.time = dictionary["time"] as? Timestamp ?? Timestamp()
    }
}
