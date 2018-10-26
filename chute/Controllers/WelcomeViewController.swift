//
//  WelcomeViewController.swift
//  chute
//
//  Created by David Doswell on 10/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

class WelcomeViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Background")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.getStartedButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
        button.backgroundColor = Appearance.customBackground
        button.addTarget(self, action: #selector(getStartedTap(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func getStartedTap(sender: UIButton) {
        let vc = PickUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        
    }

    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
     
        view.addSubview(imageView)
        view.addSubview(getStartedButton)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        getStartedButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100).isActive = true
        getStartedButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        getStartedButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
