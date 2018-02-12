//
//  ChatSendVC.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 12.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatSendVC: UIViewController {

    @IBOutlet weak var sbUsers: TransparentSearchBar!
    @IBOutlet weak var tvUsers: UITableView!
    @IBOutlet weak var btnSend: UIButton!
    
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
    
    @IBAction func onSend(_ sender: Any) {
        // TODO: Implement
        self.close()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.close()
    }
    
    func reloadUsers(data: [ChatUser]) {
        self.users = data
        self.selectedUsers.removeAll()
        self.tvUsers.reloadData()
    }
}

extension ChatSendVC : UITableViewDataSource {
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

extension ChatSendVC : UITableViewDelegate {
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
