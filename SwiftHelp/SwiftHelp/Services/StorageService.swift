//
//  StorageService.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 16.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit
import FirebaseStorage

typealias StorageThemeOpSuccess = (String?) -> Void
typealias StorageImageOpSuccess = (UIImage?) -> Void
typealias StorageOpSuccess = () -> Void
typealias StorageOpFailure = (Error) -> Void


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
                        authorID: String,
                        failure: StorageOpFailure?,
                        success: StorageThemeOpSuccess?) {
        _ = themesReference.child(name).putData(data, metadata: nil)
        { (metadata, error) in
            if let err = error {
                failure?(err)
            }
            else {
                if let filePath = metadata?.path {
                    success?(filePath)
                }
                else {
                    let invalidUrl = NSError(domain: "app",
                                             code: 400,
                                             userInfo: ["message":"Invalid download url"])
                    failure?(invalidUrl)
                }
            }
        }
    }
    
    func getTheme(filePath: String,
                  failure: StorageOpFailure?,
                  success: StorageImageOpSuccess?){
        let fileRef = storageReference.child(filePath)
        fileRef.getData(maxSize: AppConstants.MaxDownloadImageSizeInMB)
        { (data, error) in
            if let err = error {
                failure?(err)
            }
            else {
                let image = UIImage(data: data!)
                success?(image)
            }
        }
    }
    
    func deleteTheme(name: String,
                     failure: StorageOpFailure?,
                     succcess: StorageOpSuccess?){
        themesReference.child(name).delete { (error) in
            if let err = error {
                failure?(err)
            }
            else {
                succcess?()
            }
        }
    }
}
