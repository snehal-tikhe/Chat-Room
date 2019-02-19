//
//  ChannelTableViewCell.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/12/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var channelNameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        
        let name = channel.channelName ?? ""
        channelNameLbl.text = "#\(name)"
    }

}
