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
        Alamofire.request(.POST, URLString: self.authumURL+"/user", parameters: user.parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion(AuthumResponse(json: JSON), error)
        }
    }

}
