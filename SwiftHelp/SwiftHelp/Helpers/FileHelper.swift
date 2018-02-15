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
    private static let BackgroundFileName = "background"
    private static let BackgroundFileType = "png"
    
    static func saveAppBackground(image: UIImage?) -> Bool {
        if let storedImgUrl = getImgFileUrl(name: BackgroundFileName, type: BackgroundFileType) {
            if let img = image {
                if let imgData = UIImagePNGRepresentation(img) as NSData? {
                    do {
                        imgData.write(toFile: storedImgUrl.path, atomically: true)
                        return true
                    }
                    catch let error {
                        print("Error storing background : \(error.localizedDescription)")
                    }
                }
            }
        }
        
        return false
    }
    
    static func getAppBackground() -> UIImage? {
        if let storedImg = getStoredBackground() {
            return storedImg
        }
        
        return getDefaultBackground()
    }
    
    private static func getStoredBackground() -> UIImage? {
        if let storedImgUrl = getImgFileUrl(name: BackgroundFileName, type: BackgroundFileType) {
            if let image = UIImage(named: storedImgUrl.path) {
                return image
            }
        }
        
        return nil
    }
    
    private static func getDefaultBackground() -> UIImage? {
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
