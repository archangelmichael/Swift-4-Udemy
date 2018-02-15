//
//  ImageHelper.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 15.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {
    private static let backgroundName = "background_name"

    static func setAppBackground(image: UIImage?,
                                 name: String?) -> Bool {
        guard let validImage = image,
            let validName = name else {
            return false
        }
        
        let isImageStored = FileHelper.storeBackgroundImage(image: validImage,
                                                            name: validName)
        if isImageStored {
            let userDefaults = UserDefaults.standard
            userDefaults.set(validName, forKey: backgroundName)
            return userDefaults.synchronize()
        }
        
        return false
    }
    
    static func getAppBackground() -> UIImage? {
        let userDefaults = UserDefaults.standard
        if let imgName = userDefaults.object(forKey: backgroundName) as? String {
            if let storedImg = FileHelper.getStoredBackgroundImage(name: imgName) {
                return storedImg
            }
        }
        
        return FileHelper.getDefaultBackground()
    }
}
