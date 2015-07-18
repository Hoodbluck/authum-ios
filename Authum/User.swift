//
//  User.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

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
