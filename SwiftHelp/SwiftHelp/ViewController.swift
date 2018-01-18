//
//  ViewController.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 18.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ivGradient: UIImageView!
    var maskView : UIView!
    var maskLayer : CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maskView = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.ivGradient.bounds.width,
                                        height: 0));
        maskView.backgroundColor = UIColor.white.withAlphaComponent(0.8);
        self.ivGradient.addSubview(maskView);
    }

    
    @IBAction func onPercentageChange(_ sender: Any) {
        let precentage = 1 - Double((sender as! UIButton).tag)/100.0;
        self.addSublayer(percentage: precentage);
    }
    
    func addSublayer(percentage : Double) -> Void {
        let maskHeight = Double(self.ivGradient.bounds.height) * percentage;
        maskView.frame = CGRect(x: 0.0,
                                y: Double(self.ivGradient.bounds.height) - maskHeight,
                                width: Double(self.ivGradient.bounds.width),
                                height: maskHeight);
    }
}

