//
//  AppDelegate.swift
//  PushNotification
//
//  Created by Omar Alejandro Robles Altamirano on 03/01/20.
//  Copyright © 2020 Alejandro Robles. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setupPushNotification(application: application)
        return true
    }
    
    //Setup appdelegate for push notifications
    func setupPushNotification(application: UIApplication ){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if (granted){
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
            else{
                print("User notification permission denied: \(error?.localizedDescription ?? "error")")
            }
        }
    }
    
    //MARK: - UNUserNotificationCenterDelegate methods
    //Successful registration and you have a token. Send your token to your provider, in this case the console for cut and paste
    //Method 1: - Will register app on apns to receive token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Successful registration. Token is:")
        print(tokenString(deviceToken))
    }
    
    //Method 2: - Fail registration. Explain why
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Fail to register for remote notification: \(error.localizedDescription)")
    }
    
    //Method 3: - In this method app will receive notifications in [userInfo]
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    //code to make a token string
    func tokenString(_ deviceToken: Data) -> String{
        let bytes = [UInt8](deviceToken)
        var token = ""
        for byte in bytes{
            token += String(format: "%02x", byte)
        }
        return token // This token will be passed to your backend that can be written in php, js, .net, etc.
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

