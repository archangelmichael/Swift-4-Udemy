//
//  UIViewController+Child.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 29.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildVC(_ childVC: UIViewController) {
        addChildViewController(childVC)
        view.addSubview(childVC.view)
        childVC.didMove(toParentViewController: self)
    }
    
    func removeAsChild() {
        guard parent != nil else {
            return
        }
        
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
