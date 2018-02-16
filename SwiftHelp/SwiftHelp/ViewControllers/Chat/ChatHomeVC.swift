//
//  ChatHomeVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatHomeVC: BackgroundViewController {
    
    enum ThemeCategory {
        case mine, shared
    }
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var cvImages: UICollectionView!
    
    private var themes : [ChatTheme] = [ChatTheme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogout.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        
        self.cvImages.registerNib(ChatImageViewCell.self)
        self.cvImages.dataSource = self
        self.cvImages.delegate = self
        
        self.loadThemes(category: .shared)
    }
    
    @IBAction func onMyThemes(_ sender: Any) {
        self.loadThemes(category: .mine)
    }
    
    @IBAction func onSharedThemes(_ sender: Any) {
        self.loadThemes(category: .shared)
    }
    
    func loadThemes(category: ThemeCategory) {
        DataService.instance.getThemes { [weak self] (themesData) in
            self?.reloadThemes(themes: themesData)
        }
    }
    
    func reloadThemes(themes: [ChatTheme]) {
        self.themes = themes
        self.cvImages.reloadData()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let success = AuthService.instance.logout()
        if success {
            self.close()
        }
        else {
            print("Error logging out")
        }
    }
    
    @IBAction func onTakePicture(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
           print("Photo library is available")
            self.selectPicture()
        }
        else if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            print("Read camera is available")
            self.takePicture()
        }
        else {
            print("No access to photos")
        }
    }
    
    func selectPicture() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.allowsEditing = true
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    func takePicture() {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.cameraCaptureMode = .photo
        imagePickerVC.allowsEditing = true
        imagePickerVC.cameraDevice = .rear
        imagePickerVC.showsCameraControls = true;
        imagePickerVC.isNavigationBarHidden = true;
        imagePickerVC.isToolbarHidden = true;
        imagePickerVC.delegate = self
        self.present(imagePickerVC, animated: true, completion: nil)
    }
    
    func showSelectedImage(image: UIImage) {
        if let previewVC = NavigationHelper.getVC(vc: ChatBackgroundPreviewVC.self, sourceVC: self) {
            previewVC.selectedImage = image
            self.present(previewVC, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "No image selected")
        }
    }
    
    func showSelectedTheme(theme: ChatTheme) {
        if let previewVC = NavigationHelper.getVC(vc: ChatBackgroundPreviewVC.self, sourceVC: self) {
            previewVC.selectedTheme = theme
            self.present(previewVC, animated: true, completion: nil)
        }
        else {
            self.showAlert(title: "No theme selected")
        }
    }
}

extension ChatHomeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image selection cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let resizedImg = pickedImage.resized(size: 1024)
            self.showSelectedImage(image: resizedImg)
        }
    }
}

extension ChatHomeVC : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatImageViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let theme = self.themes[indexPath.row]
        cell.updateUI(theme: theme)
        return cell
    }
}

extension ChatHomeVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theme = self.themes[indexPath.row]
        self.showSelectedTheme(theme: theme)
    }
}
























