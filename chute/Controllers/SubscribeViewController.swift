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

    let subscribeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.subscribeButtonTitle, for: .normal)
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
    
    let welcomeToChutePlusImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ChutePlus")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let welcomeToChutePlusLabel : UILabel = {
        let label = UILabel()
        label.text = String.welcomeToChutePlusLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = Appearance.customBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let autoRenewMessageLabel : UILabel = {
        let label = UILabel()
        label.text = String.subscriptionText
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = Appearance.customBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsOfServiceButton : UIButton = {
        let button = UIButton(type: .system) as UIButton
        button.setTitle(String.termsOfServiceTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = Appearance.customBackground
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
        button.backgroundColor = Appearance.customBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(privacyButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc private func subscribeButtonTap(sender: UIButton) {
//        IAPHelper.shared.purchase(product: .autoRenewingSubscription)
    }
    
    @objc private func termsOfServiceButtonTap(sender: UIButton) {
//        termsOfServiceTap()
    }
    
    @objc private func privacyButtonTap(sender: UIButton) {
//        privacyButtonTap()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpLeftNavBar()
        setUpRightNavBar()
        
        setUpViews()
    }
    
    private func setUpLeftNavBar() {
        let left = UIButton(type: .custom)
        left.setTitle(String.navigationItemTitle, for: .normal)
        left.setTitleColor(.white, for: .normal)
        left.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        left.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        left.layer.masksToBounds = true
        left.contentMode = .scaleAspectFill
        left.addTarget(self, action: #selector(leftBarButtonTapped(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: left)
    }
    
    @objc private func leftBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpRightNavBar() {
        let right = UIButton(type: .custom)
        right.setTitleColor(.white, for: .normal)
        right.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.addTarget(self, action: #selector(setUpRightNavBarPop(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(setUpRightNavBarPop(sender:)))
    }
    
    @objc private func setUpRightNavBarPop(sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    private func setUpViews() {
        
        self.title = "Welcome to Chute Plus"
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        
        view.backgroundColor = Appearance.customBackground
        
        view.addSubview(subscribeButton)
        view.addSubview(welcomeToChutePlusImage)
        view.addSubview(welcomeToChutePlusLabel)
        view.addSubview(autoRenewMessageLabel)
        view.addSubview(termsOfServiceButton)
        view.addSubview(privacyPolicyButton)
        
        subscribeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
     
        welcomeToChutePlusImage.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 30).isActive = true
        welcomeToChutePlusImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeToChutePlusImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        welcomeToChutePlusImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

        welcomeToChutePlusLabel.topAnchor.constraint(equalTo: welcomeToChutePlusImage.bottomAnchor, constant: 30).isActive = true
        welcomeToChutePlusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeToChutePlusLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        welcomeToChutePlusLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        autoRenewMessageLabel.topAnchor.constraint(equalTo: welcomeToChutePlusLabel.bottomAnchor, constant: 30).isActive = true
        autoRenewMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoRenewMessageLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        autoRenewMessageLabel.heightAnchor.constraint(equalToConstant: 250).isActive = true

        termsOfServiceButton.topAnchor.constraint(equalTo: autoRenewMessageLabel.bottomAnchor, constant: 30).isActive = true
        termsOfServiceButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        termsOfServiceButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        termsOfServiceButton.heightAnchor.constraint(equalToConstant: 18).isActive = true

        privacyPolicyButton.topAnchor.constraint(equalTo: autoRenewMessageLabel.bottomAnchor, constant: 30).isActive = true
        privacyPolicyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20) .isActive = true
        privacyPolicyButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        privacyPolicyButton.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
}
