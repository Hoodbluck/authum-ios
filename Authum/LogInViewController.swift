//
//  LogInViewController.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        title = "Authum"
    }

    @IBAction func logInButtonPressed(sender: UIButton) {
        self.passwordTextField.resignFirstResponder()
        guard let email = emailTextField.text where email != "" else {
            AlertManager.sharedInstance.require("Email Address", self)
            return
        }
        guard let password = passwordTextField.text where password != "" else {
            AlertManager.sharedInstance.require("Password", self)
            return
        }

        let user = User(userId: nil, firstName: "", lastName: "", email: email, password: password, deviceToken: nil)
        AuthumService.sharedInstance.logInUser(user) { (response, error) in
            guard let response = response else {
                print("Error logging in user: \(error?.localizedDescription)")
                return
            }
            switch response.code {
            case .Success:
                let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HomeViewController")
                self.presentViewController(vc, animated: true, completion: nil)
            case .Failure:
                AlertManager.sharedInstance.failure(response, self)
            case .Warning:
                print("Error logging in user: \(response.status)")
            }
        }
    }

    @IBAction func registerButtonPressed(sender: UIButton) {
        findAndResignFirstResponder()
    }

    func findAndResignFirstResponder() {
        for property in [emailTextField, passwordTextField] {
            if property.isFirstResponder() {
                property.resignFirstResponder()
                break
            }
        }
    }

}
