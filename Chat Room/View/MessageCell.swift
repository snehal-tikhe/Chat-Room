//
//  MessageCell.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/15/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var userAvatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configureCell (message : Message) {
        
        userNameLbl.text = message.userName
        messageLbl.text = message.message
        userAvatarImageView.image = UIImage(named: message.avatarName)
        userAvatarImageView.backgroundColor = UserDataService.instance.returnUIColor(components: message.avatarColor)
        
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timestampLbl.text = finalDate
        }
    }

}
