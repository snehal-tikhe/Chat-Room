//
//  AuthService.swift
//  Chat Room
//
//  Created by Snehal Tikhe on 2/8/19.
//  Copyright © 2019 Snehal Tikhe. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
        
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler){
        let lowerCaseEmail = email.lowercased()
        
    
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {

                // old way
                //                if let responseData = response.result.value as?
                //                    Dictionary<String, Any> {
                //                    if let email = responseData["user"] as? String {
                //                        self.userEmail = email
                //                    }
                //                    if let token = responseData["token"] as? String {
                //                        self.authToken = token
                //                    }
                guard let responseData = response.data else { return }
                let json = JSON(data: responseData)
                
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
  
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler)
    {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
       
        
        print("url--------\(URL_USER_ADD)")
        
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
           
                if response.result.error == nil {
                   
                guard let responseData = response.data else { return }
                    let json = JSON(data: responseData)
                    
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    
                    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                    
                    completion(true)
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers:BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let responseData = response.data else { return }
                    let json = JSON(data: responseData)
                
                    print(json)
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                
                    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
//    func setUserInfoData(data: Data) {
//        print(data)
//
//
//
//
//        print(json)
//        // swifty JSON way
//        let id = json["_id"].stringValue
//        let color = json["avatarColor"].stringValue
//        let avatarName = json["avatarName"].stringValue
//        let email = json["email"].stringValue
//        let name = json["name"].stringValue
//
////        self.authToken = json["tiken"].stringValue
//
//        UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
//
//    }
}
