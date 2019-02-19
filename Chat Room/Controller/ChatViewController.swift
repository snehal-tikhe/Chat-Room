//
//  ChatViewController.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/6/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUsersLbl: UILabel!
    
    // Variables
    var isTyping = false
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.bindToKeyboard()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.estimatedRowHeight = 80
        messageTableView.rowHeight = UITableView.automaticDimension
        sendBtn.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver((self), selector: #selector(ChatViewController.userDataDidChanged(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        NotificationCenter.default.addObserver((self), selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelId == MessageService.instance.selectedChannel?.channelId && AuthService.instance.isLoggedIn {
                MessageService.instance.messages.append(newMessage)
                self.messageTableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.messageTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.channelId else { return }
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUsersLbl.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUsersLbl.text = ""
            }
        }
        
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
            }
        }
        
    }
    
    @objc func userDataDidChanged(_ notif: Notification){
        
        if AuthService.instance.isLoggedIn {
            
            self.onLoginGetMessages()
        }
        else {
            channelNameLbl.text = "Please Log In"
            messageTableView.reloadData()
        }
    }
    
   
    

    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelName ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.channelId else { return }
        if messageTxt.text == "" {
            isTyping = false
            sendBtn.isEnabled = false
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                sendBtn.isEnabled = true
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
            }
            isTyping = true
        }
    }
    
    @IBAction func sendMessageTapped(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.channelId else {return}
            guard let message = messageTxt.text else {return}
            
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxt.text = ""
                    self.messageTxt.resignFirstResponder()
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
                }
            }
        }
        
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No Channels Yet.."
                }
            }
        }
    }
    
    func getMessages() {
        
        let channelId = MessageService.instance.selectedChannel?.channelId
        MessageService.instance.findAllMessagesForChannel(channelId: channelId!) { (success) in
            if success{
                self.messageTableView.reloadData()
            }
            
        }
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(MessageService.instance.messages)
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            
            return cell
         } else {
            return UITableViewCell()
        }
    }
}
