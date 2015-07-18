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

    let authumURL = "https://authum.hoodbluck.com"
    
    func registerUser(user: User, completion: (AuthumResponse?, NSError?) -> Void) {
        Alamofire.request(.POST, URLString: self.authumURL)
            .responseJSON { (_, _, JSON, error) in
                print(JSON)
                completion(AuthumResponse(json: JSON), error)
        }
    }
}
