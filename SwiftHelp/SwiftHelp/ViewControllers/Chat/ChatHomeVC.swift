//
//  ChatHomeVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatHomeVC: UIViewController {
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var ivBackground: UIImageView!
    
    @IBOutlet weak var ivPreview: UIImageView!
    
    @IBOutlet weak var svDefault: UIStackView!
    @IBOutlet weak var svPreview: UIStackView!
    
    
    
    private var users : [ChatUser] = [ChatUser]()
    private var selectedUsers : [String : ChatUser] = [String : ChatUser]()
    private var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    
    func updateUI() {
        self.btnLogout.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.togglePreview(visible: false)
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
        }
    }
    
    @IBAction func onRemove(_ sender: Any) {
        self.selectedImage = nil
        self.ivPreview.image = nil
        self.ivPreview.isHidden = false
    }
    
    @IBAction func onPreview(_ sender: Any) {
        if let img = self.selectedImage {
            self.togglePreview(visible: true)
            self.ivBackground.image = img
            self.ivPreview.isHidden = true
        }
    }
    
    @IBAction func onSend(_ sender: Any) {
        if let img = self.selectedImage {
            self.present(vc: ChatSendVC.self)
        }
    }
    
    @IBAction func onClear(_ sender: Any) {
        let storedBackground = FileHelper.getDefaultBackground()
        self.ivBackground.image = storedBackground
        
        self.togglePreview(visible: false)
        self.selectedImage = nil
        self.ivPreview.image = nil
    }
    
    @IBAction func onSave(_ sender: Any) {
        // TODO: Store selected image as default image
        self.togglePreview(visible: false)
    }
    
    func togglePreview(visible: Bool) {
        self.svDefault.isHidden = visible
        self.svPreview.isHidden = !visible
        self.ivPreview.isHidden = !visible
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
























