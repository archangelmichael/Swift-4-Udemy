//
//  ImageHelper.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 15.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ImageHelper: NSObject {
    private static var _backgroundImg:  UIImage?
    private static var _tempBackgroundImg: UIImage?
    
    static var backgroundImg: UIImage? {
        set{
            _backgroundImg = newValue
        }
        get {
            if _backgroundImg == nil {
                _backgroundImg = FileHelper.getAppBackground()
            }
            
            return _backgroundImg
        }
    }
    
    static var tempBackgroundImg : UIImage? {
        set {
            _tempBackgroundImg = newValue
        }
        get {
            return _tempBackgroundImg
        }
    }
}
