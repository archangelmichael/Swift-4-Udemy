//
//  DataService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DataService: NSObject {

    private static let _instance = DataService()
    
    static var instance : DataService {
        return _instance
    }
    
    var dbReference: DatabaseReference {
        return Database.database().reference()
    }
    
    func saveUser(userID: String) {
        let profile = ["firstname" : "Name", "lastname" : "Surname"]
        dbReference.child("users").child(userID).child("profile").setValue(profile)
    }
}
