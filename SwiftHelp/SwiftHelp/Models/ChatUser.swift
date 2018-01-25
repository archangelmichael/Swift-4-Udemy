//
//  ChatUser.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

struct ChatUser {
    private var _uid : String
    private var _firstname: String?
    private var _lastname: String?
    private var _email : String?
    
    var uid : String {
        get { return _uid }
    }
    
    var firstname : String? {
        get {  return _firstname }
    }
    
    var lastname : String? {
        get { return _lastname }
    }
    
    var fullname : String? {
        get { return "\(firstname ?? "") \(lastname ?? "")" }
    }
    
    var email : String? {
        get {
            return _email
        }
    }
    
    init(uid: String, firstname: String?, lastname: String?, email: String?) {
        _uid = uid
        _firstname = firstname
        _lastname = lastname
        _email = email
    }
}
