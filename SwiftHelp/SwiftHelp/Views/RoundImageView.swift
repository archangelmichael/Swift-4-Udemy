//
//  RoundImageView.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

// Uncomment to see how it actually looks in storyboard design time
//@IBDesignable
class RoundImageView: UIImageView {

    @IBInspectable
    var cornerRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
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
