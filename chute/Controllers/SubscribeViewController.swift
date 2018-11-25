//
//  SubscribeViewController.swift
//  chute
//
//  Created by David Doswell on 9/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import SafariServices

class SubscribeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    let chuteImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Chute3")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let plusLabel : UILabel = {
        let label = UILabel()
        label.text = "PLUS"
        label.textColor = Appearance.customBackground
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(1.0))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subscribeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.subscribeButtonTitle2, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = Appearance.customBackground
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subscribeButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let unlimtedPickUpLabel : UILabel = {
        let label = UILabel()
        label.text = String.unlimitedPickUpLabelTitle
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let autoRenewMessageLabel : UILabel = {
        let label = UILabel()
        label.text = String.subscriptionText
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: -0.3))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsOfServiceButton : UIButton = {
        let button = UIButton(type: .system) as UIButton
        button.setTitle(String.termsOfServiceTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(termsOfServiceButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let privacyPolicyButton : UIButton = {
        let button = UIButton(type: .system) as UIButton
        button.setTitle(String.privacyButtonTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(privacyButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func subscribeButtonTap(sender: UIButton) {
        
        // TODO: Uncomment once StoreKit is implemented
        
//        IAPHelper.shared.purchase(product: .autoRenewingSubscription)
    }
    
    @objc private func termsOfServiceButtonTap(sender: UIButton) {
        termsOfServiceTap()
    }
    
    @objc private func privacyButtonTap(sender: UIButton) {
        privacyButtonTap()
    }
    
    private func privacyButtonTap() {
        if let url = URL(string: "") {
            let configuration = SFSafariViewController.Configuration()
            configuration.barCollapsingEnabled = false
            
            let safariViewController = SFSafariViewController(url: url, configuration: configuration)
            safariViewController.preferredBarTintColor = Appearance.customBackground
            safariViewController.preferredControlTintColor = .white
            present(safariViewController, animated: true)
        }
    }
    
    private func termsOfServiceTap() {
        if let url = URL(string: "") {
            let configuration = SFSafariViewController.Configuration()
            configuration.barCollapsingEnabled = false
            
            let safariViewController = SFSafariViewController(url: url, configuration: configuration)
            safariViewController.preferredBarTintColor = Appearance.customBackground
            safariViewController.preferredControlTintColor = .white
            present(safariViewController, animated: true)
        }
    }
    
    @objc private func handleGesture(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setUpViews() {
        
        view.backgroundColor = Appearance.lightBackground

        view.addSubview(chuteImageView)
        view.addSubview(plusLabel)
        view.addSubview(unlimtedPickUpLabel)
        view.addSubview(autoRenewMessageLabel)
        view.addSubview(subscribeButton)
        view.addSubview(termsOfServiceButton)
        view.addSubview(privacyPolicyButton)
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        plusLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 20.0).isActive = true
        plusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        plusLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        plusLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true

        unlimtedPickUpLabel.topAnchor.constraint(equalTo: autoRenewMessageLabel.topAnchor, constant: -30.0).isActive = true
        unlimtedPickUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        unlimtedPickUpLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        unlimtedPickUpLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        autoRenewMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoRenewMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        autoRenewMessageLabel.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        autoRenewMessageLabel.heightAnchor.constraint(equalToConstant: 250.0).isActive = true
        
        subscribeButton.topAnchor.constraint(equalTo: autoRenewMessageLabel.bottomAnchor, constant: 30.0).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        termsOfServiceButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 30.0).isActive = true
        termsOfServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        termsOfServiceButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        termsOfServiceButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true

        privacyPolicyButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 30.0).isActive = true
        privacyPolicyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0) .isActive = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
    }
    
}
