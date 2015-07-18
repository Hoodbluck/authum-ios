//
//  AuthumResponse.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

struct AuthumResponse {

    let code: Int /// Status of the action, -1 = failure, 0 = success, 1 = warning
    let status: String /// Response code, this code should be specified on the API process definition.
    let value: String? /// Response value, this is an optional field to return information.

    init(code: Int, status: String, value: String?) {
        self.code = code
        self.status = status
        self.value = value
    }

    init?(json: AnyObject?) {
        guard let jsonDict = json as? [String: AnyObject?] else {
            return nil
        }
        
        guard let code = jsonDict["code"] as? Int else {
            return nil
        }
        guard let status = jsonDict["status"] as? String else {
            return nil
        }
        let value = jsonDict["value"] as? String

        self.init(code: code, status: status, value: value)
    }

}

