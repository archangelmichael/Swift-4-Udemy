//
//  ChatTheme.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 16.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatTheme: NSObject {
    private var _uid: String
    private var _name: String?
    private var _author: String?
    private var _url: String?
    
    var uid : String { get { return _uid } }
    var name: String? { get { return _name } }
    var author : String? { get {  return _author } }
    var url : String? { get { return _url } }
    
    init(uid: String,
         name: String?,
         author: String?,
         url: String?) {
        _uid = uid
        _name = name
        _author = author
        _url = url
    }
}
