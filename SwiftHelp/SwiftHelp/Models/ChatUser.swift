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
    private var _firstname: String
    private var _lastname: String
    
    var uid : String {
        get { return _uid }
    }
    
    var firstname : String {
        get {  return _firstname }
    }
    
    var lastname : String {
        get { return _lastname }
    }
    
    var fullname : String {
        get { return "\(firstname) \(lastname)"}
    }
    
    init(uid: String, name: String, surname: String) {
        _uid = uid
        _firstname = name
        _lastname = surname
    }
}
