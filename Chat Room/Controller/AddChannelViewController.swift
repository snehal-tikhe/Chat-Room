//
//  AddChannelViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/12/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    // outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var channelNameTxt: UITextField!
    @IBOutlet weak var channelDescriptionTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }

    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelTapped(_ sender: Any) {
        
        guard let channelName = channelNameTxt.text, channelNameTxt.text != "" else {return}
        guard let channelDescription = channelDescriptionTxt.text else {return}
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        
        channelNameTxt.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        channelDescriptionTxt.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedString.Key.foregroundColor : purpleTextFieldPlaceHolder])
        
        let closeTouch = UITapGestureRecognizer(target: self, action:#selector(AddChannelViewController.closeTap(_:)))
        
        view.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
