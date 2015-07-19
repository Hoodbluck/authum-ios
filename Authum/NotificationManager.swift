//
//  NotificationManager.swift
//  Authum
//
//  Created by Nelida Velazquez on 7/18/15.
//  Copyright © 2015 Hoodbluck. All rights reserved.
//

import UIKit

class NotificationManager {

    static let sharedInstance = NotificationManager()
    
    let kAcceptActionTitle = "Accept"
    let kAcceptActionIdentifier = "ACCEPT_ACTION_ID"
    let kDeclineActionTitle = "Decline"
    let kDeclineActionIdentifier = "DECLINE_ACTION_ID"
    let kCategoryIdentifier = "AUTHENTICATE_CATEGORY"
    
    func registerForPushNotifications() {
        UIApplication.sharedApplication().registerUserNotificationSettings(userNotificationSettings())
        UIApplication.sharedApplication().registerForRemoteNotifications()
    }
    
    func registerCurrentUserDeviceToken(deviceToken: NSData) {
    
        guard let currentUser = AuthumService.sharedInstance.currentUser else {
            print("No user to register")
            return
        }
        
        var stringToken = deviceToken.description
        stringToken = stringToken.stringByReplacingOccurrencesOfString("<", withString: "")
        stringToken = stringToken.stringByReplacingOccurrencesOfString(">", withString: "")
        stringToken = stringToken.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        AuthumService.sharedInstance.registerDeviceToken(stringToken, forUser:currentUser) { (response, error) in
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
    
    func userNotificationSettings() -> UIUserNotificationSettings {
    
        let acceptAction = UIMutableUserNotificationAction()
        acceptAction.title = kAcceptActionTitle
        acceptAction.identifier = kAcceptActionIdentifier
        acceptAction.activationMode = UIUserNotificationActivationMode.Background
        acceptAction.authenticationRequired = false
        
        let declineAction = UIMutableUserNotificationAction()
        declineAction.title = kDeclineActionTitle
        declineAction.identifier = kDeclineActionIdentifier
        declineAction.activationMode = UIUserNotificationActivationMode.Background
        declineAction.authenticationRequired = false
        
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = kCategoryIdentifier
        category.setActions([acceptAction,declineAction], forContext: UIUserNotificationActionContext.Default)
        category.setActions([acceptAction,declineAction], forContext: UIUserNotificationActionContext.Minimal)
        
        var categories = Set<UIUserNotificationCategory>()
        categories.insert(category)
        return UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge], categories: categories)
    }
    
    func handleNotificationAction(actionIdentifier: String?, forClient client: String?) {
    
        guard let clientId = client else {
            return
        }
        
        switch actionIdentifier {
        
        case .Some(kAcceptActionIdentifier):
            AuthumService.sharedInstance.confirmAuthorization(clientId, accepted:true)
        case .Some(kDeclineActionIdentifier):
            AuthumService.sharedInstance.confirmAuthorization(clientId, accepted:false)
        default:
            print("\(actionIdentifier) Not found")
        }
    }
}
