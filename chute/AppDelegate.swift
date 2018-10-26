//
//  AppDelegate.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = LoginViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        navigationController.navigationBar.isHidden = true
        
        Appearance.setUpAppearance()
        
        _ = Appearance.applicationFont(with: UIFont.TextStyle(rawValue: "REZ"), pointSize: 50)
        
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (success, error) in
            if let error = error {
                NSLog("Notification request denied by user: \(error)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

