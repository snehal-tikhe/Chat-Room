//
//  LoginViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/7/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "createAccountSegue", sender: nil)
    }    
}
