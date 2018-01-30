//
//  ChatHomeVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatHomeVC: UIViewController {

    @IBOutlet weak var sbarSearch: TransparentSearchBar!
    @IBOutlet weak var tvUsers: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var ivBackground: UIImageView!
    
    private var users : [ChatUser] = [ChatUser]()
    private var selectedUsers : [String : ChatUser] = [String : ChatUser]()
    private var selectedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvUsers.rowHeight = UITableViewAutomaticDimension
        self.tvUsers.estimatedRowHeight = ChatUserCell.defaultEstimatedHeight
        
        self.tvUsers.registerNib(ChatUserCell.self)
        self.tvUsers.dataSource = self
        self.tvUsers.delegate = self
        
        DataService.instance.getUsers { [weak self] (usersData) in
            self?.reloadUsers(data: usersData)
        }
    }
    
    func reloadUsers(data: [ChatUser]) {
        self.users = data
        self.selectedUsers.removeAll()
        self.tvUsers.reloadData()
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
            self.ivBackground.image = image
        }
    }
    
    @IBAction func onSend(_ sender: Any) {
        
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

extension ChatHomeVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatUserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.updateUI(user: self.users[indexPath.row])
        return cell
    }
}

extension ChatHomeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ChatUserCell {
            cell.mark(selected: true)
            self.selectUser(user: self.users[indexPath.row], selected: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ChatUserCell {
            cell.mark(selected: false)
            self.selectUser(user: self.users[indexPath.row], selected: false)
        }
    }
    
    func selectUser(user: ChatUser, selected: Bool) {
        self.selectedUsers[user.uid] = selected ? user : nil
        self.btnSend.isEnabled = self.selectedUsers.count > 0
    }
}
























