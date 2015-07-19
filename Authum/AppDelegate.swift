//
//  AppDelegate.swift
//  Authum
//
//  Created by Andrew Clissold on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        
        guard let currentUser = AuthumService.sharedInstance.currentUser else {
            print("No user to register")
            return
        }
        
        let token = String(data: deviceToken, encoding: NSUTF8StringEncoding)
        
        AuthumService.sharedInstance.registerDeviceToken(token, forUser:currentUser) { (response, error) in
            guard let response = response else {
                print("Error registering device token: \(error?.localizedDescription)")
                return
            }
            
            switch response.code {
            case .Success:
                print("Device was registered successfully: \(response.status)")
            case .Failure:
                print("Error registering device token: \(response.status)")
            case .Warning:
                print("Device was registered with warning : \(response.status)")
            }
        }

    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Fail to register remote notification: \(error)")
    }
}
