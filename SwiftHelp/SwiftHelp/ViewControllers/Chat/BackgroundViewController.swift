//
//  BackgroundViewController.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 15.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class BackgroundViewController: UIViewController {

    private let backgroundTag = 999
    private var backgroundView : UIImageView? {
        get {
            return self.view.viewWithTag(backgroundTag) as? UIImageView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshBackground()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshBackground()
    }

    func refreshTempBackground() {
        backgroundView?.image = ImageHelper.tempBackgroundImg
    }
    
    func refreshBackground() {
        backgroundView?.image = ImageHelper.backgroundImg
    }
}
