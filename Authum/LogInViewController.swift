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
