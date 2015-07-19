//
//  AlertManager.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit

class AlertManager {

    static let sharedInstance = AlertManager()

    private init() {}

    func require(field: String, _ viewController: UIViewController) {
        let title = "\(field) Required"
        let message = "Please enter your \(field.lowercaseString) and try again."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }

    func requirePasswordConfirmation(viewController: UIViewController) {
        let title = "Passwords Do Not Match"
        let message = "Please ensure that you typed your password correctly and try again."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }

    func failure(response: Response, _ viewController: UIViewController) {
        let title = "Error Code \(response.code.rawValue)"
        let message = response.value as? String ?? ""
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)

    }

}
