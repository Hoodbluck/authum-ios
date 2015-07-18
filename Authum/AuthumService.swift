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

    let authumURL = "http://authum.hoodbluck.com"
    
    func registerUser(user: User, completion: (AuthumResponse?, NSError?) -> Void) {
        
        let parameters = [
            "firstName" : user.firstName,
            "lastName" : user.lastName,
            "email" : user.email,
            "password" : user.password
        ]
        
        Alamofire.request(.POST, URLString: self.authumURL+"/user", parameters: parameters)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion(AuthumResponse(json: JSON), error)
        }
    }
}
