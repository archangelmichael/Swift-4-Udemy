//
//  FileHelper.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 12.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    private static let DefaultBackgroundFileName = "login-background"
    
    static func storeBackgroundImage(image: UIImage?,
                                     name: String?,
                                     type: String? = AppConstants.UploadImageType) -> Bool {
        guard let validImage = image,
            let validName = name,
            let validType = type else {
            return false
        }
        
        if let storedImgUrl = getImgFileUrl(name: validName, type: validType) {
            if let imgData = UIImageJPEGRepresentation(validImage, 1.0) as NSData? {
                imgData.write(toFile: storedImgUrl.path, atomically: true)
                return true
            }
        }
        
        return false
    }
    
    static func getStoredBackgroundImage(name: String?,
                                         type: String? = AppConstants.UploadImageType) -> UIImage? {
        guard let validName = name,
            let validType = type else {
                return nil
        }
        
        if let storedImgUrl = getImgFileUrl(name: validName, type: validType) {
            if let image = UIImage(named: storedImgUrl.path) {
                return image
            }
        }
        
        return nil
    }
    
    public static func getDefaultBackground() -> UIImage? {
        return UIImage(named: DefaultBackgroundFileName)
    }
    
    private static func getImgFileUrl(name: String, type: String) -> URL? {
        if let imgsUrl = getImgsUrl() {
            return imgsUrl.appendingPathComponent("\(name).\(type)")
        }
        
        return nil
    }
    
    private static func getImgsUrl() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
