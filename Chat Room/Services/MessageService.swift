//
//  MessageService.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/12/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService
{
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel : Channel?
    
    func findAllChannels(completion : @escaping CompletionHandler)
    {
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let responseData = response.data else { return }
                
                if let json = JSON(data: responseData).array {
                    for item in json {
                        
                        let id = item["_id"].stringValue
                        let name = item["name"].stringValue
                        let desc = item["description"].stringValue
                        
                        let channel = Channel(channelId: id, channelName: name, channelDescription: desc)
                        self.channels.append(channel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllMessagesForChannel(channelId : String, completion: @escaping CompletionHandler) {

        self.clearMessages()
        
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let responseData = response.data else { return }
                if let json = JSON(data: responseData).array {
                    
                    for item in json {
                                                
                        let id = item["_id"].stringValue
                        let channelId = item["channelId"].stringValue
                        let message = item["messageBody"].stringValue
                        let userName = item["userName"].stringValue
                        let avatarName = item["userAvatar"].stringValue
                        let avatarColor = item["userAvatarColor"].stringValue
                        let timestamp = item["timeStamp"].stringValue
                        
                        let newMessage = Message(id : id, channelId : channelId, message: message, userName: userName, avatarName: avatarName, avatarColor: avatarColor, timeStamp: timestamp)
                        self.messages.append(newMessage)
                    }
//                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
            } else {
                completion(false)
                debugPrint(response.result.error as Any)

            }
        }
    }
    
    func clearMessages() {
        self.messages.removeAll()
    }
    
    func clearChannels() {
        self.channels.removeAll()
    }
    
}
