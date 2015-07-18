//
//  AuthumService.swift
//  Authum
//
//  Created by Nelida Velazquez on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit
import Alamofire

class AuthumService {

    private let authumURL = "http://authum.hoodbluck.com"
    
    func registerUser(user: User, completion: ((Response?, NSError?) -> Void)?) {
        Alamofire.request(.POST, URLString: self.authumURL+"/user", parameters: user.parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion?(Response(json: JSON), error)
        }
    }

    func registerDeviceToken(token: String, forUser user: User, completion: ((AuthumResponse?, NSError?) -> Void)?){
        
        guard let userID = user.userId else{
            completion?(nil, NSError(domain: "Something", code: -1, userInfo: nil));
            return
        }
        
        let deviceURL = self.authumURL+"/user/\(userID)/deviceToken"
        
        Alamofire.request(.POST, URLString:deviceURL, parameters: ["deviceToken" : token], encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion?(AuthumResponse(json: JSON), error)
        }
    }
}
