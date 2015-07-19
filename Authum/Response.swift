//
//  Response.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import Foundation

struct Response {

    let code: ResponseCode /// Status code of the action, -1 = failure, 0 = success, 1 = warning.
    let status: String /// Response status, this should be specified on the API process definition.
    let value: AnyObject? /// Response value, this is an optional field to return information.

    init(code: ResponseCode, status: String, value: AnyObject?) {
        self.code = code
        self.status = status
        self.value = value
    }

    init?(json: AnyObject?) {
        guard let jsonDict = json as? NSDictionary else {
            return nil
        }
        guard let rawStatusCode = jsonDict["code"] as? Int else {
            return nil
        }
        guard let code = ResponseCode(rawValue: rawStatusCode) else {
            print("unexpected response code: \(rawStatusCode)")
            return nil
        }
        guard let status = jsonDict["status"] as? String else {
            return nil
        }
        
        guard let value = jsonDict["value"] as AnyObject? else{
            return nil
        }

        self.init(code: code, status: status, value: value)
    }

}

