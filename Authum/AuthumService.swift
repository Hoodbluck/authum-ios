//
//  AuthumService.swift
//  Authum
//
//  Created by Nelida Velazquez on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit
import Alamofire

//
//enum Router: URLRequestConvertible {
//    static let baseUrlString = "some url string"
//
//    var URLRequest: NSURLRequest {
//        let path = "/get"
//        let parameters = ["q": "query"]
//
//        let URL = NSURL(string: Router.baseUrlString)!
//        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
//        URLRequest.setValue("com.hoodbluck.ios", forHTTPHeaderField: "User-Agent")
//
//        let encoding = Alamofire.ParameterEncoding.URL
//        let (request, error) = encoding.encode(URLRequest, parameters: parameters)
//        if error != nil {
//            print("Error encoding URL: \(error!.localizedDescription)")
//        }
//        return request
//    }
//}

class AuthumService {

    let authumURL = "http://authum.hoodbluck.com"

    func registerUser(user: User, completion: ((Response?, NSError?) -> Void)?) {
        // Set the User-Agent header.
        var headers = Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        headers["User-Agent"] = "com.hoodbluck.ios"
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        let manager = Manager(configuration: configuration)

        manager.request(.POST, authumURL+"/user", parameters: user.parameters, encoding: .JSON)
            .responseJSON { (_, _, JSON, error) in
                completion?(Response(json: JSON), error)
        }
    }

}
