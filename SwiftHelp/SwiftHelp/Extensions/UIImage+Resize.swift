//
//  UIImage+Resize.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

extension UIImage {
    func resized(size: CGFloat) -> UIImage {
        let scale = size / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: size, height: newHeight)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        
        let image = renderer.image { (context) in
            self.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        }
        
        return image
    }
}
