//
//  ChatUserCell.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 25.01.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatUserCell: UITableViewCell {

    @IBOutlet weak var ivAvatar: RoundImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            let imageChecked = #imageLiteral(resourceName: "check-mark").resized(size: 30.0)
            self.accessoryView = UIImageView(image: imageChecked)
        }
        else {
            self.accessoryView = nil
        }
    }
    
}
