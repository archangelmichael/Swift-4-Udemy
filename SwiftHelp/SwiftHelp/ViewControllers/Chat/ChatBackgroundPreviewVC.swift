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
    @IBOutlet weak var btnDelete: UIButton!
    
    var selectedTheme: ChatTheme?
    var selectedImage: UIImage?
    let selectedThemeAuthor : String? = AuthService.instance.loggedUserName
    var selectedThemeName: String?
    var selectedThemeUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.selectedTheme {
            self.updateActions(save: false, apply: true, delete: true)
        }
        else if let _ = self.selectedImage {
            self.updateActions(save: true, apply: false, delete: false)
        }
        else {
            self.updateActions(save: false, apply: false, delete: false)
        }
        
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
    
    @IBAction func onSave(_ sender: Any) {
        self.selectedThemeName = "\(DateHelper.getDateTimeStamp()).png"
        if let themeAuthor = self.selectedThemeAuthor,
            let themeName = self.selectedThemeName,
            let image = self.selectedImage,
            let imageData = UIImagePNGRepresentation(image)
             {
            
            StorageService.instance.storeThemeData(data: imageData,
                                                   name: themeName,
                                                   author: themeAuthor)
            { [weak self] (themeUrl, error) in
                if let err = error {
                    self?.showAlert(title: "Error uploading image", message: err.localizedDescription)
                }
                else {
                    self?.selectedThemeUrl = themeUrl
                    self?.updateActions(save: false, apply: true, delete: true)
                }
            }
        }
    }

    @IBAction func onApply(_ sender: Any) {
        let imageSaved = ImageHelper.setAppBackground(image: self.selectedImage,
                                                      name: DateHelper.getDateTimeStamp())
        if imageSaved {
            self.updateActions(save: false, apply: false, delete: true)
        }
        else {
            self.showAlert(title: "Error saving image")
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        if let themeName = self.selectedThemeName {
            StorageService.instance.deleteTheme(name: themeName,
                                                completion:
                { [weak self] (error) in
                    if let err = error {
                        self?.showAlert(title: "Error deleting image",
                                        message: err.localizedDescription)
                    }
                    else {
                        self?.close()
                    }
            })
        }
    }
    
    func updateActions(save: Bool,
                       apply: Bool,
                       delete: Bool) {
        self.btnSave.isHidden = !save
        self.btnApply.isHidden = !apply
        self.btnDelete.isHidden = !delete
    }
}
