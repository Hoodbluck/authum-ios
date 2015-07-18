//
//  User.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

extension User: Parameterizable {
    var parameters: [String: AnyObject] {
        get {
            var dictionary: [String: AnyObject] = [:]
            if let userId = userId {
                dictionary["userId"] = userId
            }
            dictionary["firstName"] = firstName
            dictionary["lastName"] = lastName
            dictionary["email"] = email
            dictionary["password"] = password
            if let deviceToken = deviceToken {
                dictionary["deviceToken"] = deviceToken
            }
            return dictionary
        }
    }
}

struct User {

    var userId: Double? /// User's id.
    let firstName: String /// User's first name.
    let lastName: String /// User's last name.
    let email: String /// User's email.
    let password: String /// User's password.
    var deviceToken: String? /// User's device token.

    init(userId: Double?, firstName: String, lastName: String, email: String, password: String, deviceToken: String?) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.deviceToken = deviceToken
    }

    init?(json: [String: AnyObject]) {
        let userId = json["userId"] as? Double
        guard let firstName = json["firstName"] as? String else {
            return nil
        }
        guard let lastName = json["lastName"] as? String else {
            return nil
        }
        guard let email = json["email"] as? String else {
            return nil
        }
        guard let password = json["password"] as? String else {
            return nil
        }
        let deviceToken = json["deviceToken"] as? String

        self.init(userId: userId, firstName: firstName, lastName: lastName, email: email, password: password, deviceToken: deviceToken)
    }

}
