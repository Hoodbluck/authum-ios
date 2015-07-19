//
//  AuthumService.swift
//  Authum
//
//  Created by Nelida Velazquez on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class AuthumService {
    
    var currentUser: User?
    
    static let sharedInstance = AuthumService()

    private let authumURL = "http://authum.hoodbluck.com"
    
    private init() {}
    
    func registerUser(user: User, completion: ((Response?, NSError?) -> Void)?) {
        Alamofire.request(.POST, URLString: self.authumURL+"/user", parameters: user.parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                
                let response = Response(json: JSON)
                
                if let jsonUser = response?.value as AnyObject?{
                    self.currentUser = User(json: jsonUser)
                }
                
                completion?(response, error)
        }
    }

    func registerDeviceToken(token: String, forUser user: User, completion: ((Response?, NSError?) -> Void)?){
        
        guard let userID = user.userId else{
            completion?(nil, NSError(domain: "No userID to register", code: -1, userInfo: nil));
            return
        }
        
        let deviceURL = self.authumURL+"/user/\(userID)/deviceToken"
        
        Alamofire.request(.POST, URLString:deviceURL, parameters: ["deviceToken" : token], encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion?(Response(json: JSON), error)
        }
    }
}
