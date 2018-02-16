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
    
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var vLoading: UIActivityIndicatorView!
    
    private var _themeName : String?
    
    var themeName : String {
        get {
            if let theme = self.selectedTheme
                {
                return theme.name
            }
            else if let name = _themeName {
                return name
            }
            else {
                _themeName = "\(DateHelper.getDateTimeStamp())\(AppConstants.UploadImageType)"
                return _themeName!
            }
        }
    }
    
    var selectedTheme: ChatTheme?
    var selectedImage: UIImage?
    let selectedThemeAuthor : String? = AuthService.instance.loggedUserName
    let selectedThemeAuthorID : String? = AuthService.instance.loggedUserID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = self.selectedTheme {
            self.updateActions(share: true, save: false, apply: true, delete: true)
        }
        else if let _ = self.selectedImage {
            self.updateActions(share: false, save: true, apply: false, delete: false)
        }
        else {
            self.updateActions()
        }
        
        self.updateBackground()
    }
    
    func updateBackground() {
        if let image = self.selectedImage {
            self.ivBackground.image = image
        }
        else {
            self.ivBackground.image = ImageHelper.getAppBackground()
        }
        
        if let theme = self.selectedTheme {
            self.vLoading.startAnimating()
            StorageService.instance.getTheme(filePath: theme.filePath,
                                             failure: errorCallback)
                { [weak self] (image) in
                    self?.vLoading.stopAnimating()
                    self?.selectedImage = image
                    self?.ivBackground.image = image
            }
        }
    }

    @IBAction func onBack(_ sender: Any) {
        self.close()
    }
    
    @IBAction func onShare(_ sender: Any) {
        if let theme = self.selectedTheme,
            let sendVC = NavigationHelper.getVC(vc: ChatSendVC.self, sourceVC: self) {
            sendVC.selectedTheme = theme
            self.present(sendVC, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "No theme selected")
        }
    }
    
    @IBAction func onSave(_ sender: Any) {
        if  let themeAuthor = self.selectedThemeAuthor,
            let themeAuthorID = self.selectedThemeAuthorID,
            let image = self.selectedImage,
            let imageData = UIImageJPEGRepresentation(image, AppConstants.UploadImageCompressionQuality) {
            
            self.vLoading.startAnimating()
            StorageService.instance.storeThemeData(data: imageData,
                                                   name: themeName,
                                                   author: themeAuthor,
                                                   authorID: themeAuthorID,
                                                   failure: errorCallback)
            { [weak self] (themePath) in
                guard let weakself = self else {
                    return;
                }
                
                if let themePath = themePath {
                    DataService.instance.saveTheme(name: weakself.themeName,
                                                   author: themeAuthor,
                                                   authorID: themeAuthorID,
                                                   filePath: themePath,
                                                   failure:
                        { [weak self] (error) in
                            guard let weakself = self else {
                                return;
                            }
                            
                            StorageService.instance.deleteTheme(name: weakself.themeName,
                                                                failure: nil,
                                                                succcess: nil)
                            weakself.errorCallback(error: error)
                    })
                    { [weak self] (theme) in
                        self?.vLoading.stopAnimating()
                        self?.selectedTheme = theme
                        weakself.updateActions(share: false,
                                               save: false,
                                               apply: true,
                                               delete: true)
                    }
                }
                else {
                    self?.errorCallback(error: NSError(domain: "app",
                                                       code: 400,
                                                       userInfo: ["message" : ""]))
                }
            }
        }
    }

    @IBAction func onApply(_ sender: Any) {
        self.vLoading.startAnimating()
        let imageSaved = ImageHelper.setAppBackground(image: self.selectedImage,
                                                      name: DateHelper.getDateTimeStamp())
        self.vLoading.stopAnimating()
        if imageSaved {
            self.updateActions(share: true,
                               save: false,
                               apply: false,
                               delete: true)
        }
        else {
            self.showAlert(title: "Error saving image")
        }
    }
    
    @IBAction func onDelete(_ sender: Any) {
        self.vLoading.startAnimating()
        StorageService.instance.deleteTheme(name: themeName,
                                            failure: errorCallback)
            { [weak self] () in
                self?.vLoading.stopAnimating()
                self?.close()
        }
        
        if let theme = self.selectedTheme {
            DataService.instance.deleteTheme(theme: theme,
                                             failure: errorCallback,
                                             success: nil)
        }
    }
    
    func errorCallback(error: Error) {
        self.vLoading.stopAnimating()
        self.showAlert(title: "Error deleting image",
                       message: error.localizedDescription)
    }
    
    func updateActions(share: Bool = false,
                       save: Bool = false,
                       apply: Bool = false,
                       delete: Bool = false) {
        self.btnShare.isHidden = !share
        self.btnSave.isHidden = !save
        self.btnApply.isHidden = !apply
        self.btnDelete.isHidden = !delete
    }
}
