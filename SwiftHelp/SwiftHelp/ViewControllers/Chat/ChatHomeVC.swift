//
//  ChatHomeVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatHomeVC: BackgroundViewController {
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var ivPreview: UIImageView!
    @IBOutlet weak var svSelection: UIStackView!
    @IBOutlet weak var svPreview: UIStackView!
    
    private var users : [ChatUser] = [ChatUser]()
    private var selectedUsers : [String : ChatUser] = [String : ChatUser]()
    private var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogout.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.toggle()
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
    
    func showSelectedPicture() {
        if let image = self.selectedImage {
            self.ivPreview.image = image
            self.toggle(hideSelection: false, hidePreview: true)
        }
        else {
            self.clearSelectedImage()
            self.showAlert(title: "No image selected")
        }
    }
    
    @IBAction func onRemove(_ sender: Any) {
        self.clearSelectedImage()
    }
    
    @IBAction func onPreview(_ sender: Any) {
        if let img = self.selectedImage {
            ImageHelper.tempBackgroundImg = img
            self.refreshTempBackground()
            self.toggle(hideSelection: true, hidePreview: false)
            }
        else {
            self.clearSelectedImage()
            self.showAlert(title: "No image selected")
        }
    }
    
    @IBAction func onSend(_ sender: Any) {
        if let img = self.selectedImage {
            self.present(vc: ChatSendVC.self)
        }
        else {
            self.clearSelectedImage()
            self.showAlert(title: "No image selected")
        }
    }
    
    @IBAction func onClear(_ sender: Any) {
        self.clearSelectedImage()
    }
    
    @IBAction func onSave(_ sender: Any) {
        if let img = self.selectedImage {
            if FileHelper.saveAppBackground(image: img) {
                ImageHelper.backgroundImg = img
                ImageHelper.tempBackgroundImg = nil
                self.clearSelectedImage()
            }
            else {
                self.clearSelectedImage()
                self.showAlert(title: "Error storing selected image")
            }
        }
        else {
            self.clearSelectedImage()
            self.showAlert(title: "No image selected")
        }
    }
    
    func clearSelectedImage() {
        ImageHelper.tempBackgroundImg = nil
        self.toggle()
        self.selectedImage = nil
        self.ivPreview.image = nil
        self.refreshBackground()
    }
    
    func toggle(hideSelection: Bool = true,
                hidePreview: Bool = true) {
        self.svSelection.isHidden = hideSelection
        self.ivPreview.isHidden = hideSelection
            
        self.svPreview.isHidden = hidePreview
    }
}

extension ChatHomeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image selection cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectedImage = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        self.showSelectedPicture()
    }
}
























