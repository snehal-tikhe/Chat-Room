//
//  Constants.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/8/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://chatappst.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNELS = "\(BASE_URL)/channel/"
let URL_GET_MESSAGES = "\(BASE_URL)/message/byChannel/"


//segues
let LOGIN_SEGUE = "loginSegue"
let CREATE_ACCOUNT_SEGUE = "createAccountSegue"
let UNWIND_SEGUE = "unwindSegue"
let AVATAR_PICKER_SEGUE = "AvatarPickerSegue"


// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//header

let HEADER = ["Content-Type": "application/json; chharset=utf-8"]

let BEARER_HEADER = ["Authorization": "Bearer \(AuthService.instance.authToken)","Content-Type": "application/json; chharset=utf-8"]
//colors
let purpleTextFieldPlaceHolder = #colorLiteral(red: 0.5386462312, green: 0.2818205562, blue: 1, alpha: 0.5)

//Notification constants
let NOTIF_USER_DATA_CHANGED = Notification.Name("notifUserDataChanged")
let NOTIF_CHANNELS_LOADED = Notification.Name("channelsLoaded")
let NOTIF_CHANNEL_SELECTED = Notification.Name("channelsSelected")



