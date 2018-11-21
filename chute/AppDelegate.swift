//
//  AppDelegate.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = LoginViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationController.navigationBar.barTintColor = Appearance.customBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        navigationController.navigationBar.isHidden = true
        
//        let image = UIImage(named: "Chute")
//        let imageView = UIImageView(image: image)
//
//        let bannerWidth = navigationController.navigationBar.frame.size.width
//        let bannerHeight = navigationController.navigationBar.frame.size.height
//
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
//
//        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
//
//        imageView.contentMode = .scaleAspectFit
//
//        navigationController.navigationBar.topItem?.titleView = imageView
//        
        
        Appearance.setUpAppearance()
        
        _ = Appearance.applicationFont(with: UIFont.TextStyle(rawValue: "REZ"), pointSize: 50)
        
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (success, error) in
            if let error = error {
                NSLog("Notification request denied by user: \(error)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        
        FirebaseApp.configure()
        
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
