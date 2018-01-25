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
        
        DataService.instance.getUsers { (snapshot) in
            print(snapshot.debugDescription)
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
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatUserCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        return cell
    }
}
