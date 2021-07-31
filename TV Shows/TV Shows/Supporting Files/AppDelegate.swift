//
//  AppDelegate.swift
//  TV Shows
//
//  Created by Infinum Infinum on 08.07.2021..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        let authInfo: AuthInfo? = AuthStorage.load()
        
        if authInfo != nil {
            let storyboard = UIStoryboard(name: "Home", bundle: .main)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController.viewControllers = [homeViewController]
            
            // Jel potreban ovaj dio posto je tak default way?
        } else {
            let storyboard = UIStoryboard(name: "Login", bundle: .main)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController.viewControllers = [loginViewController]
        }
        /// Sets the navigation controller as starting point of the app
        window?.rootViewController = navigationController
        
        return true
    }
}
