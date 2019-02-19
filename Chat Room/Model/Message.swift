//
//  Message.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/13/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import Foundation

struct Message {
    public private(set) var id : String!
    public private(set) var channelId : String!
    public private(set) var message : String!
    public private(set) var userName : String!
    public private(set) var avatarName : String!
    public private(set) var avatarColor : String!
    public private(set) var timeStamp : String!
}
