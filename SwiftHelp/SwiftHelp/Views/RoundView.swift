//
//  RoundView.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 24.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

@IBDesignable
class RoundView: UIView {

    @IBInspectable
    var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth : CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
}
