//
//  ViewAnimator.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 1/29/18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ViewAnimator: NSObject {

    private var animatedView: UIView!
    private var parentView: UIView!
    
    private var propertyAnimator: UIViewPropertyAnimator?
    
    init?(targetView : UIView) {
        if let parentView = targetView.superview {
            self.parentView = parentView
            self.animatedView = targetView
        }
        else {
            return nil
        }
    }
    
    func start() {
        let propertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
        self.animatedView.center = self.parentView.center
        
        // Add our first animation block
        propertyAnimator.addAnimations {
            self.animatedView.center.y = self.parentView.center.y + self.parentView.bounds.height / 2;
        }
        
        // Now here goes our second
        propertyAnimator.addAnimations {
            self.animatedView.alpha = 0.0
        }
        
        propertyAnimator.addCompletion {
            position in
            switch position {
            case .end: print("Completion handler called at end of animation")
                self.animatedView.removeFromSuperview()
            case .current: print("Completion handler called mid-way through animation")
            case .start: print("Completion handler called  at start of animation")
            }
        }
        
        propertyAnimator.startAnimation()
    }
}
