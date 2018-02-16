//
//  StorageService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 16.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseStorage

typealias StoreThemeCompletion = (String?, Error?) -> Void
typealias DeleteThemeCompletion = ((Error?) -> Void)?

class StorageService: NSObject {
    private static let _instance = StorageService()
    
    static var instance : StorageService {
        return _instance
    }
    
    private var storageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    private var themesReference: StorageReference {
        return storageReference.child("themes")
    }
    
    func storeThemeData(data: Data,
                        name: String,
                        author: String,
                        completion: StoreThemeCompletion?) {
        _ = themesReference.child(name).putData(data, metadata: nil)
        { (metadata, error) in
            guard let metadata = metadata else {
                completion?(nil, error)
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            if let downloadURL = metadata.downloadURL() {
                completion?(downloadURL.path, nil)
            }
            else {
                let invalidUrl = NSError(domain: "app",
                                         code: 400,
                                         userInfo: ["message":"Invalid download url"])
                completion?(nil, invalidUrl)
            }
        }
    }
    
    func deleteTheme(name: String,
                     completion: DeleteThemeCompletion) {
        themesReference.child(name).delete(completion: completion)
    }
}
