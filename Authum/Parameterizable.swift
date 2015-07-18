//
//  Parameterizable.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

/// Provides automatic conversion to the parameterized representation that Alamofire expects.
protocol Parameterizable {

    /// The parameterized representation that Alamofire expects.
    var parameters: [String: AnyObject] { get }
}
