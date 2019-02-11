//
//  CircleImageView.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/10/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit


@IBDesignable
class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        setUpView()
    }

    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    func setUpView()
    {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    
}
