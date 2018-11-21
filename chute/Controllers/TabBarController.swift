//
//  TabBarController.swift
//  chute
//
//  Created by David Doswell on 11/20/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class TabBarController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarController = UITabBarController()
        
        let tabViewController1 = DashboardViewController()
        let tabViewController2 = ShopTableViewController()
        let tabViewController3 = OrdersViewController()
        let tabViewController4 = SubscribeViewController()
        let tabViewController5 = InfoViewController()
        
        let controllers = [tabViewController1, tabViewController2, tabViewController3, tabViewController4, tabViewController5]
        
        tabBarController.viewControllers = controllers
        
        let firstImage = UIImage(named: "Profile")
        let secondImage = UIImage(named: "Shop")
        let thirdImage = UIImage(named: "Orders")
        let fourthImage = UIImage(named: "Plus")
        let fifthImage = UIImage(named: "Info")
        
        tabViewController1.tabBarItem = UITabBarItem(title: "Profile", image: firstImage, tag: 1)
        
        tabViewController2.tabBarItem = UITabBarItem(title: "Shop", image: secondImage, tag: 2)
        
        tabViewController3.tabBarItem = UITabBarItem(title: "Orders", image: thirdImage, tag: 3)
        
        tabViewController4.tabBarItem = UITabBarItem(title: "Plus", image: fourthImage, tag: 4)
        
        tabViewController5.tabBarItem = UITabBarItem(title: "Info", image: fifthImage, tag: 5)
        
        tabBarController.tabBar.barTintColor = .white
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        
        let image = UIImage(named: "Chute")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navigationController.navigationBar.frame.size.width
        let bannerHeight = navigationController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        imageView.contentMode = .scaleAspectFit
        
        navigationController.navigationBar.topItem?.titleView = imageView

    }

}
