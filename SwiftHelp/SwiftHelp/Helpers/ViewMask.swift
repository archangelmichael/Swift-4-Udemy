//
//  ViewMask.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 30.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ViewMask: NSObject {
    static func addCenterMask(toView maskView: UIView?) -> Void {
        guard let mask = maskView else {
            return;
        }
        
        let radius = min(mask.bounds.width, mask.bounds.height) / 2 - 20;
        let maskLayer = CAShapeLayer()
        
        // Create a path with the rectangle in it.
        let path = UIBezierPath(rect: mask.bounds)
        // Put a circle path in the middle
        path.addArc(withCenter:CGPoint(x: mask.bounds.width/2 ,
                                       y: mask.bounds.height/2 ),
                    radius: radius,
                    startAngle: 0.0,
                    endAngle: CGFloat(2*Double.pi),
                    clockwise: true)
        
        // Give the mask layer the path you just draw
        maskLayer.path = path.cgPath
        // Fill rule set to exclude intersected paths
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // By now the mask is a rectangle with a circle cut out of it. Set the mask to the view and clip.
        mask.layer.mask = maskLayer
        mask.clipsToBounds = true
    }
}
