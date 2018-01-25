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
    
    private var users : [ChatUser] = [ChatUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvUsers.rowHeight = UITableViewAutomaticDimension
        self.tvUsers.estimatedRowHeight = ChatUserCell.defaultEstimatedHeight
        
        self.tvUsers.registerNib(ChatUserCell.self)
        self.tvUsers.dataSource = self
        self.tvUsers.delegate = self
        
        DataService.instance.getUsers { [unowned self] (usersData) in
            print(usersData.debugDescription)
            self.reloadUsers(data: usersData)
        }
    }
    
    func reloadUsers(data: [ChatUser]) {
        DispatchQueue.main.async {
            self.users = data
            self.tvUsers.reloadData()
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        let success = AuthService.instance.logout()
        if success {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            print("Error logging out")
        }
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
        let cell: ChatUserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.mark(selected: cell.isMarked ? false : true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
