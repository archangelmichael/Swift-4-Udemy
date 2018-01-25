//
//  DataService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseDatabase

typealias DataFetchCompletion = (DataSnapshot) -> Void

class DataService: NSObject {

    private static let _instance = DataService()
    
    static var instance : DataService {
        return _instance
    }
    
    private var dbReference: DatabaseReference {
        return Database.database().reference()
    }
    
    private var usersReference: DatabaseReference {
        return dbReference.child("users")
    }
    
    func saveUser(uid: String,
                  firstname: String?,
                  lastname: String?,
                  email: String?) {
        let profile = ["email" : email,
                       "firstname" : firstname,
                       "lastname" : lastname]
        usersReference.child(uid).child("profile").setValue(profile)
    }
    
    func getUsers(completion: @escaping DataFetchCompletion) {
        usersReference.observe(DataEventType.value,
                               with: completion)
    }
}
