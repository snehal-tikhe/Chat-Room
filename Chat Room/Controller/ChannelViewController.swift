//
//  ChannelViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/6/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    // IBOutlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImageView: CircleImageView!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var channelsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelsTableView.delegate = self
        channelsTableView.dataSource = self
        
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 80
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelsTableView.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupUserInfo()
    }
    
    @objc func userDataDidChange(_ notif: Notification){
        self.setupUserInfo()
    }
    
    @objc func channelsLoaded(_ notif : Notification) {
        channelsTableView.reloadData()
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
            channelsTableView.reloadData()
        }
    }
    
    
    // IBActions
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    @IBAction func addChannelTapped(_ sender: Any){
        if AuthService.instance.isLoggedIn {
            let addChannel = AddChannelViewController()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
            
        } else {
            print("You have to login first")
        }
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
    
    //tableview datasource and delegates methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Channel count -: \(MessageService.instance.channels.count)")
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelTableViewCell {
            
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell;
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        self.revealViewController()?.revealToggle(animated: true)
    }
   
}
