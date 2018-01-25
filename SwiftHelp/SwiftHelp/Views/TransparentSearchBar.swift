//
//  TransparentSearchBar.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

@IBDesignable
class TransparentSearchBar: UISearchBar {

    @IBInspectable
    var searchTextColor : UIColor? {
        didSet {
            if let searchTextField = value(forKey: "searchField") as? UITextField {
                searchTextField.textColor = searchTextColor
            }
        }
    }
    
    @IBInspectable
    var placeholderColor: UIColor? {
        didSet {
            if let searchTextField = value(forKey: "searchField") as? UITextField {
                let placeholderString =
                    searchTextField.attributedPlaceholder?.string != nil ?
                    searchTextField.attributedPlaceholder!.string : ""
                let attrPlaceholder = NSAttributedString(string: placeholderString,
                                                         attributes: [NSAttributedStringKey.foregroundColor: placeholderColor!])
                searchTextField.attributedPlaceholder = attrPlaceholder
            }
        }
    }

}
