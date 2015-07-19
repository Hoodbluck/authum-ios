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
            AlertManager.sharedInstance.require("First Name", self)
            return
        }
        guard let lastName = lastNameTextField.text where lastName != "" else {
            AlertManager.sharedInstance.require("Last Name", self)
            return
        }
        guard let email = emailTextField.text where email != "" else {
            AlertManager.sharedInstance.require("Email Address", self)
            return
        }
        guard let password = passwordTextField.text where password != "" else {
            AlertManager.sharedInstance.require("Password", self)
            return
        }
        guard let confirmPassword = confirmPasswordTextField.text
        where confirmPassword != "" && password == confirmPassword else {
            AlertManager.sharedInstance.requirePasswordConfirmation(self)
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
                    NotificationManager.sharedInstance.registerForPushNotifications()
                })
            case .Failure:
                AlertManager.sharedInstance.failure(response, self)
            case .Warning:
                print("Error registering user: \(response.status)")
            }
        }
        confirmPasswordTextField.resignFirstResponder()
    }
}
