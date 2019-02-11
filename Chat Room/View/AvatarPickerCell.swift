//
//  AvatarPickerCell.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/10/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

enum AvatarType{
    case light
    case dark
}

class AvatarPickerCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarPickerImgView: UIImageView!
    
    override func awakeFromNib() {
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType)
    {
        avatarPickerImgView.backgroundColor = UIColor.lightGray

        if type == AvatarType.dark{
        avatarPickerImgView.image = UIImage.init(named: "dark\(index)")
        }else{
            avatarPickerImgView.image = UIImage.init(named: "light\(index)")
            
        }
    }
    
    func setUpView() {
        self.layer.cornerRadius = 10;
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
    }
    
}
