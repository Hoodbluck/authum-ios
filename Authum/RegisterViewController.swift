//
//  RegisterViewController.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func registerButtonTapped(sender: UIButton) {
        registerNewUser()
    }

    func registerNewUser() {
        guard let firstName = firstNameTextField.text where firstName != "" else {
            require("First Name")
            return
        }
        guard let lastName = lastNameTextField.text where lastName != "" else {
            require("Last Name")
            return
        }
        guard let email = emailTextField.text where email != "" else {
            require("Email Address")
            return
        }
        guard let password = passwordTextField.text where password != "" else {
            require("Password")
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text
        where confirmPassword != "" && password == confirmPassword else {
            requireConfirmPassword()
            return
        }

        let user = User(userId: nil, firstName: firstName, lastName: lastName, email: email, password: password, deviceToken: nil)
        AuthumService.sharedInstance.registerUser(user) { (response, error) in
            guard let response = response else {
                print("Error registering user: \(error?.localizedDescription)")
                return
            }
            switch response.code {
            case .Success:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HomeViewController")
                self.presentViewController(vc, animated: true, completion: { () -> Void in
                    NotificationManager.sharedInstance.registerToPushNotifications()
                })
            case .Failure:
                self.showRegistrationFailureAlert(response)
            case .Warning:
                print("Error registering user: \(response.status)")
            }
        }
        confirmPasswordTextField.resignFirstResponder()
    }

    // MARK: Alerts

    func require(field: String) {
        let title = "\(field) Required"
        let message = "Please enter your \(field.lowercaseString) and try again."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    func requireConfirmPassword() {
        let title = "Passwords Do Not Match"
        let message = "Please ensure that you typed your password correctly and try again."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    func showRegistrationFailureAlert(response: Response) {
        let title = "Error Code \(response.code.rawValue)"
        let message = response.status
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true, completion: nil)

    }
}
