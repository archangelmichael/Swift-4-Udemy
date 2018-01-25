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
    
    private var users : [ChatUser] = [ChatUser]()
    private var selectedUsers : [String : ChatUser] = [String : ChatUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvUsers.rowHeight = UITableViewAutomaticDimension
        self.tvUsers.estimatedRowHeight = ChatUserCell.defaultEstimatedHeight
        
        self.tvUsers.registerNib(ChatUserCell.self)
        self.tvUsers.dataSource = self
        self.tvUsers.delegate = self
        
        DataService.instance.getUsers { [unowned self] (usersData) in
            self.reloadUsers(data: usersData)
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
        
    }
    
    @IBAction func onSend(_ sender: Any) {
        
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
























