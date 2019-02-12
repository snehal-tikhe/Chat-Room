//
//  LoginViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/7/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        guard let email = emailTxt.text, emailTxt.text != "" else { return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return}
        
        AuthService.instance.loginUser(email: email, password: password, completion: {
            (success) in
            if success{
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success{
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object:nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })
            }
        })
    }
    
    
    
    func setupView()
    {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        emailTxt.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
        
    }
}
