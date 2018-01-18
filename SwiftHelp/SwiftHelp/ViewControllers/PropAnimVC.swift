//
//  PropAnimVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 18.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class PropAnimVC: UIViewController {

    @IBOutlet weak var vAnimate: UIView!
    var propertyAnimator: UIViewPropertyAnimator?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onStart(_ sender: Any) {
        
        let propertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
        
        // Add our first animation block
        propertyAnimator.addAnimations {
            self.moveDown()
        }
        
        // Now here goes our second
        propertyAnimator.addAnimations {
            self.vAnimate.alpha = 0.7
        }
        
        propertyAnimator.addCompletion {
            position in
            switch position {
            case .end: print("Completion handler called at end of animation")
            case .current: print("Completion handler called mid-way through animation")
            case .start: print("Completion handler called  at start of animation")
            }
        }
        
        propertyAnimator.startAnimation()
    }
    
    @IBAction func onStop(_ sender: Any) {
        let propertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
        
        // Add our first animation block
        propertyAnimator.addAnimations {
            self.moveUp()
        }
        
        // Now here goes our second
        propertyAnimator.addAnimations {
            self.vAnimate.alpha = 0.3
        }
        
        propertyAnimator.addCompletion {
            position in
            switch position {
            case .end: print("Completion handler called at end of animation")
            case .current: print("Completion handler called mid-way through animation")
            case .start: print("Completion handler called  at start of animation")
            }
        }
        
        propertyAnimator.startAnimation()    }
    
    func moveUp() -> Void {
        self.vAnimate.center.y = self.view.center.y - self.vAnimate.bounds.height;
    }
    
    func moveDown() -> Void {
        self.vAnimate.center.y = self.view.center.y + self.vAnimate.bounds.height;
    }

}
