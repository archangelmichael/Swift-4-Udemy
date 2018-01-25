//
//  UIViewController+Navigation.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

protocol NavigationController: class {
    static var defaultStoryboardIdentifier: String { get }
}

extension NavigationController where Self: UIViewController {
    static var defaultStoryboardIdentifier: String {
        return NSStringFromClass(self).components(separatedBy:".").last!
    }
}

extension UIViewController : NavigationController {
    func present<T : UIViewController>(vc: T.Type,
                                       push: Bool? = true,
                                       animated: Bool = true,
                                       completion: (() -> Void)? = nil,
                                       storyboardName: String? = nil) {
        var sourceStoryboard : UIStoryboard? = self.storyboard
        if storyboardName != nil {
            sourceStoryboard = UIStoryboard(name: storyboardName!, bundle: Bundle.main)
        }
        
        if let nextVCStoryboard = sourceStoryboard {
            let nextVC = nextVCStoryboard.instantiateViewController(withIdentifier: T.defaultStoryboardIdentifier)
            if push != nil && !push! {
                self.present(nextVC, animated: animated, completion: completion)
            }
            else {
                if let navVC = self.navigationController {
                    navVC.pushViewController(nextVC, animated: animated)
                }
                else {
                    self.present(nextVC, animated: animated, completion: completion)
                }
            }
        }
        else {
            print("Invalid navigation")
        }
    }
    
    func close(animated: Bool = true,
               completion: (() -> Void)? = nil) {
        if let navVC = self.navigationController {
            navVC.popViewController(animated: animated)
        }
        else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
}
