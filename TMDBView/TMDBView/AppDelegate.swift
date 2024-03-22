//
//  AppDelegate.swift
//  TMDBView
//
//  Created by Cuitlahuac Daniel on 25/02/23.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let initVC = LoginRouter.createModule()
        let navController = UINavigationController(rootViewController: initVC)
        let window = UIWindow()
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

