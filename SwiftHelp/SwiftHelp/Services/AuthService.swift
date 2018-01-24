//
//  AuthService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class AuthService: NSObject {
    
    private static let _instance = AuthService()
    
    static var instance : AuthService {
        return _instance
    }
    
    var isUserLogged : Bool {
        get {
            return Auth.auth().currentUser != nil
        }
    }
    
    func login(email:String, pass:String, completion: ((Bool, String?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: pass) { [unowned self] (user, error) in
            if error != nil {
                print("Login error \(error?.localizedDescription ?? "")")
                if let errorCode = (error as NSError?)?.code, errorCode == AuthErrorCode.userNotFound.rawValue {
                    self.register(email: email, pass: pass, completion: completion)
                }
                else {
                    completion?(false, error?.localizedDescription ?? "")
                }
            }
            else {
                print("Login done")
                completion?(true, nil)
            }
        }
    }
    
    func register(email:String, pass:String, completion: ((Bool, String?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                print("Register error \(error?.localizedDescription ?? "")")
                completion?(false, error?.localizedDescription ?? "")
            }
            else {
                print("Register done")
                completion?(true, nil)
            }
        }
    }
    
    func logout() -> Bool {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            return true
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        return false
    }
}
