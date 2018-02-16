//
//  FirebaseDataParser.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

import FirebaseDatabase

class FirebaseDataParser: NSObject {
    static func getChatUsers(snapshot: DataSnapshot) -> [ChatUser] {
        var users = [ChatUser]()
        if let usersDict = snapshot.value as? Dictionary<String, AnyObject> {
            for (key, value) in usersDict {
                if let profileDict = value as? Dictionary<String, AnyObject> {
                    if let profile = profileDict["profile"] as? Dictionary<String, AnyObject> {
                        if let email = profile["email"] as? String,
                           let firstname = profile["firstname"] as? String,
                            let lastname = profile["lastname"] as? String {
                            users.append(ChatUser(uid: key,
                                                  firstname: firstname,
                                                  lastname: lastname,
                                                  email: email))
                        }
                    }
                }
            }
            
            return users
        }
        else {
            return users
        }
    }
    
    static func getChatThemes(snapshot: DataSnapshot) -> [ChatTheme] {
        var themes = [ChatTheme]()
        if let themesDict = snapshot.value as? Dictionary<String, AnyObject> {
            for (key, value) in themesDict {
                if let themeDict = value as? Dictionary<String, AnyObject> {
                    if  let name = themeDict["name"] as? String,
                        let author = themeDict["author"] as? String,
                        let url = themeDict["url"] as? String {
                        themes.append(ChatTheme(uid: key,
                                                name: name,
                                                author: author,
                                                url: url))
                    }
                }
            }
            
            return themes
        }
        else {
            return themes
        }
    }
}
