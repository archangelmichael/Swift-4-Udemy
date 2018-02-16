//
//  ChatImageViewCell.swift
//  SwiftHelp
//
//  Created by Radi Shikerov on 16.02.18.
//  Copyright © 2018 Radi. All rights reserved.
//

import UIKit

class ChatImageViewCell: UICollectionViewCell {

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI(theme: ChatTheme) {
        self.lblDate.text = theme.name.replacingOccurrences(of: ".png", with: "")
        self.lblAuthor.text = theme.author
    }

}
