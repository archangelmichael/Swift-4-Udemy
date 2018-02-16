//
//  DataService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseDatabase

typealias FetchUsersCompletion = ([ChatUser]) -> Void
typealias FetchThemesCompletion = ([ChatTheme]) -> Void

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
    
    private var themesReference: DatabaseReference {
        return dbReference.child("themes")
    }
    
    func saveUser(uid: String,
                  firstname: String?,
                  lastname: String?,
                  email: String?) {
        let profile = [
            "email" : email,
            "firstname" : firstname,
            "lastname" : lastname
        ]
        
        usersReference.child(uid).child("profile").setValue(profile)
    }
    
    func getUsers(completion: FetchUsersCompletion?) {
        usersReference.observe(DataEventType.value) { (snapshot) in
            let users = FirebaseDataParser.getChatUsers(snapshot: snapshot)
            completion?(users)
        }
    }
    
    func saveTheme(name: String?,
                   author: String?,
                   url: String?) {
        let theme = [
            "name" : name,
            "author" : author,
            "url" : url
        ]
        
        themesReference.setValue(theme)
    }
    
    func getThemes(completion: FetchThemesCompletion?) {
        themesReference.observe(DataEventType.value) { (snapshot) in
            let themes = FirebaseDataParser.getChatThemes(snapshot: snapshot)
            completion?(themes)
        }
    }
}
