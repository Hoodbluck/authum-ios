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
        NotificationManager.sharedInstance.registerCurrentUserDeviceToken(deviceToken)
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Fail to register remote notification: \(error)")
    }
}
