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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 80
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
   
}
