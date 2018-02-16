//
//  DataService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseDatabase

typealias DataUsersOpSuccess = ([ChatUser]) -> Void

typealias DataThemesOpSuccess = ([ChatTheme]) -> Void
typealias DataThemeOpSuccess = (ChatTheme?) -> Void
typealias DataThemeOpFailure = (Error) -> Void

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
    
    func getUsers(completion: DataUsersOpSuccess?) {
        usersReference.observe(DataEventType.value) { (snapshot) in
            let users = FirebaseDataParser.getChatUsers(snapshot: snapshot)
            completion?(users)
        }
    }
    
    func getThemes(completion: DataThemesOpSuccess?) {
        themesReference.observe(DataEventType.value) { (snapshot) in
            let themes = FirebaseDataParser.getChatThemes(snapshot: snapshot)
            completion?(themes)
        }
    }
    
    func getThemeByID(themeID: String,
                      completion: DataThemeOpSuccess?) {
        themesReference.child(themeID).observe(DataEventType.value)
        { (snapshot) in
            let theme = FirebaseDataParser.getChatTheme(snapshot: snapshot)
            completion?(theme)
        }
    }
    
    func saveTheme(name: String,
                   author: String,
                   authorID: String,
                   filePath: String,
                   failure: DataThemeOpFailure?,
                   success: DataThemeOpSuccess?) {
        let theme = [
            "name" : name,
            "author" : author,
            "authorID" : authorID,
            "filePath" : filePath,
            "viewers" : [String]()
            ] as [String : Any]
        
        themesReference.childByAutoId().setValue(theme)
        { [weak self] (error, dbRef) in
            if let err = error {
                failure?(err)
            }
            else {
                self?.getThemeWithRef(dbRef: dbRef, completion: success)
            }
        }
    }
    
    func updateTheme(theme: ChatTheme,
                     viewers: [String],
                     failure: DataThemeOpFailure?,
                     success: DataThemeOpSuccess?) {
        let themeRef = themesReference.child(theme.uid)
        let themeUpdate = ["viewers" : viewers] as [String : Any]
        themeRef.updateChildValues(themeUpdate)
        { [weak self] (error, dbRef) in
            if let err = error {
                failure?(err)
            }
            else {
                self?.getThemeWithRef(dbRef: dbRef, completion: success)
            }
        }
    }
    
    func deleteTheme(theme: ChatTheme,
                     failure: DataThemeOpFailure?,
                     success: DataThemeOpSuccess?) {
        themesReference.child(theme.uid).removeValue
            { [weak self]  (error, dbRef) in
            if let err = error {
                failure?(err)
            }
            else {
                self?.getThemeWithRef(dbRef: dbRef, completion: success)
            }
        }
    }
    
    func getThemeWithRef(dbRef: DatabaseReference,
                         completion: DataThemeOpSuccess?) {
        dbRef.observe(DataEventType.value,
                      with:
            { (snapshot) in
                let theme = FirebaseDataParser.getChatTheme(snapshot: snapshot)
                completion?(theme)
        })
    }
}
