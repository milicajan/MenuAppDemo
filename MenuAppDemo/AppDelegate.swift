//
//  AppDelegate.swift
//  MenuAppDemo
//
//  Created by Milica Jankovic on 26/08/2020.
//  Copyright © 2020 Milica Jankovic. All rights reserved.
//

import UIKit
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let token = UserDefaults.standard.string(forKey: "userToken"), !token.isEmpty {
            window?.rootViewController = UINavigationController(rootViewController: ListOfVenuesViewController())
        } else {
           window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

