//
//  MaskVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 18.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class MaskVC: UIViewController {

    @IBOutlet weak var ivMasked: UIImageView!
    @IBOutlet weak var vMask: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addMask();
    }
    
    func addMask() -> Void {
        let radius = self.vMask.bounds.height / 2 - 20;
        let maskLayer = CAShapeLayer()

        // Create a path with the rectangle in it.
        let path = UIBezierPath(rect: self.vMask.bounds)
        // Put a circle path in the middle
        path.addArc(withCenter:CGPoint(x: self.vMask.bounds.width/2 ,
                                       y: self.vMask.bounds.height/2 ),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: CGFloat(2*Double.pi),
                    clockwise: true)

        // Give the mask layer the path you just draw
        maskLayer.path = path.cgPath
        // Fill rule set to exclude intersected paths
        maskLayer.fillRule = kCAFillRuleEvenOdd

        // By now the mask is a rectangle with a circle cut out of it. Set the mask to the view and clip.
        self.vMask.layer.mask = maskLayer
        self.vMask.clipsToBounds = true
    }
}
