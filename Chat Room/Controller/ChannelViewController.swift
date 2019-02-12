//
//  ChannelViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/6/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImageView: CircleImageView!
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 80
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUserInfo()
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        self.setupUserInfo()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
            
        } else {
            self.performSegue(withIdentifier: LOGIN_SEGUE, sender: nil)
        }
    }
    
    func setupUserInfo()
    {
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImageView.image = UIImage(named: "profileDefault")
            userImageView.backgroundColor = UIColor.clear
        }
    }
    
   
}
