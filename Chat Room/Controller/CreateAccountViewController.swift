//
//  CreateAccountViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/7/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var avatarImg: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            avatarName = UserDataService.instance.avatarName
            userImageView.image = UIImage(named: avatarName)
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: UNWIND_SEGUE, sender: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let name = usernameTxt.text, usernameTxt.text != "" else { return}
        guard let email = emailTxt.text, emailTxt.text != "" else { return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return}

        AuthService.instance.registerUser(email: email, password: password)
        { (success)in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: {
                    (success) in
                    if success{
                        print("name = \(name)")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                self.activityIndicator.isHidden = true
                                self.activityIndicator.stopAnimating()
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND_SEGUE, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object:nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func backgroundColorTapped(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255

        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        
        avatarColor = "[\(r),\(g),\(b),1]"
        
        UIView.animate(withDuration: 0.2){
            self.userImageView.backgroundColor = self.bgColor
        }
    }
    
    @IBAction func chooseAvatarTapped(_ sender: Any) {
        performSegue(withIdentifier: "AvatarPickerSegue", sender: nil)
    }
    
    func setupView()
    {
        activityIndicator.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
}
