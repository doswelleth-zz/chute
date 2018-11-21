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
    
    let subscribeImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SubscribeBackground")
        image.contentMode = .scaleAspectFill
        image.alpha = 0.8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let chuteImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Chute")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let subscribeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.subscribeButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subscribeButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let welcomeToChutePlusLabel : UILabel = {
        let label = UILabel()
        label.text = String.welcomeToChutePlusLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let autoRenewMessageLabel : UILabel = {
        let label = UILabel()
        label.text = String.subscriptionText
        label.textColor = .white
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
        button.setTitleColor(.white, for: .normal)
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
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(privacyButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func subscribeButtonTap(sender: UIButton) {
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
        
        view.backgroundColor = .white
        
        view.addSubview(subscribeImageView)
        view.addSubview(chuteImageView)
        view.addSubview(subscribeButton)
        view.addSubview(welcomeToChutePlusLabel)
        view.addSubview(autoRenewMessageLabel)
        view.addSubview(termsOfServiceButton)
        view.addSubview(privacyPolicyButton)
        
        subscribeImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        subscribeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        subscribeImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        subscribeButton.topAnchor.constraint(equalTo: welcomeToChutePlusLabel.topAnchor, constant: -60.0).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        welcomeToChutePlusLabel.topAnchor.constraint(equalTo: autoRenewMessageLabel.topAnchor, constant: -50.0).isActive = true
        welcomeToChutePlusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeToChutePlusLabel.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        welcomeToChutePlusLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true

        autoRenewMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoRenewMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        autoRenewMessageLabel.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        autoRenewMessageLabel.heightAnchor.constraint(equalToConstant: 250.0).isActive = true

        termsOfServiceButton.topAnchor.constraint(equalTo: autoRenewMessageLabel.bottomAnchor, constant: 30.0).isActive = true
        termsOfServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        termsOfServiceButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        termsOfServiceButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true

        privacyPolicyButton.topAnchor.constraint(equalTo: autoRenewMessageLabel.bottomAnchor, constant: 30.0).isActive = true
        privacyPolicyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0) .isActive = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 18.0).isActive = true
    }
    
}
