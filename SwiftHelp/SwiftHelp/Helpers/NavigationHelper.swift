//
//  NavigationHelper.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 15.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class NavigationHelper: NSObject {
    
    enum Storyboard : String {
        case ChatStoryboard
    }
    
    static func getVC<T: UIViewController>(vc: T.Type,
                                           storyboardName: Storyboard) -> T? {
        let sourceStoryboard = UIStoryboard(name: storyboardName.rawValue, bundle: Bundle.main)
        return getVC(vc: vc, storyboard: sourceStoryboard)
    }
    
    static func getVC<T: UIViewController>(vc: T.Type,
                                           sourceVC: UIViewController?) -> T? {
        guard let sourceStoryboard = sourceVC?.storyboard else {
            return nil
        }
        
        return getVC(vc: vc, storyboard: sourceStoryboard)
    }
    
    private static func getVC<T: UIViewController>(vc: T.Type,
                                                   storyboard: UIStoryboard?) -> T? {
        return storyboard?.instantiateViewController(withIdentifier: T.defaultStoryboardIdentifier) as? T
    }
    
}
