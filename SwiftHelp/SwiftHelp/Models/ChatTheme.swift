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
    private var _name: String
    private var _author: String
    private var _authorID: String
    private var _filePath: String
    private var _viewers: [String]?
    
    var uid : String { get { return _uid } }
    var name: String { get { return _name } }
    var author : String { get {  return _author } }
    var authorID : String { get {  return _authorID } }
    var filePath : String { get { return _filePath } }
    var viewers: [String]? { get { return _viewers } }
    
    init(uid: String,
         name: String,
         author: String,
         authorID: String,
         filePath: String,
         viewers: [String]? = nil) {
        _uid = uid
        _name = name
        _author = author
        _authorID = authorID
        _filePath = filePath
        _viewers = viewers
    }
}
