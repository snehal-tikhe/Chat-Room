//
//  ProfileViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/11/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        self.setupView()
    }

    @IBAction func closeTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupView(){
        
        nameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        profileImageView.image = UIImage(named: UserDataService.instance.avatarName)
        profileImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    }
}
