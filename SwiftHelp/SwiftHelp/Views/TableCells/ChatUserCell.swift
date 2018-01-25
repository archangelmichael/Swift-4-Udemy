//
//  ChatUserCell.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatUserCell: UITableViewCell {
    
    var isMarked: Bool = false

    @IBOutlet weak var ivAvatar: RoundImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(user: ChatUser) {
        self.lblName.text = user.fullname
        self.lblEmail.text = user.email
    }
    
    func mark(selected: Bool) {
        let imageChecked = #imageLiteral(resourceName: "check-mark").resized(size: 30.0)
        self.accessoryView = selected ? UIImageView(image: imageChecked) : nil
        self.isMarked = selected
    }
}
