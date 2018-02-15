//
//  ChatBackgroundPreviewVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 15.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatBackgroundPreviewVC: UIViewController {

    @IBOutlet weak var ivBackground: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var btnApply: UIButton!
    
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnApply.isHidden = true
        self.btnSave.isHidden = false
        self.ivBackground.image = self.selectedImage
    }

    @IBAction func onBack(_ sender: Any) {
        self.close()
    }
    
    @IBAction func onShare(_ sender: Any) {
        if let image = self.selectedImage,
            let sendVC = NavigationHelper.getVC(vc: ChatSendVC.self, sourceVC: self) {
            sendVC.selectedImage = image
            self.present(sendVC, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "No image selected")
        }
    }
    
    @IBAction func onApply(_ sender: Any) {
        
    }
    
    @IBAction func onSave(_ sender: Any) {
        let imageSaved = ImageHelper.setAppBackground(image: self.selectedImage,
                                                      name: getDate())
        if imageSaved {
            self.btnSave.isHidden = true
            self.btnApply.isHidden = false
        }
        else {
            self.showAlert(title: "Error saving image")
        }
    }

    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy-hh:mm:ss"
        return formatter.string(from: date)
    }
}
