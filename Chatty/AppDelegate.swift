//
//  AppDelegate.swift
//  ChatRoom
//
//  Created by typedef on 2/13/20.
//  Copyright © 2020 typedef. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow()
        let mainNavigationViewController = UINavigationController(rootViewController: ChatRoomView())
        self.window?.rootViewController = mainNavigationViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
}

