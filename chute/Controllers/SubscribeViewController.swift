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
    }
    
    let subscribeButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.subscribeButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = Appearance.customBackground
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(subscribeButtonTap(sender:)), for: .touchUpInside)
        return button
    }()
    
    let welcomeToChutePlusLabel : UILabel = {
        let label = UILabel()
        label.text = String.welcomeToChutePlusLabelText
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let autoRenewMessageLabel : UILabel = {
        let label = UILabel()
        label.text = String.subscriptionText
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: -0.3))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsOfServiceButton : UIButton = {
        let button = UIButton(type: .system) as UIButton
        button.setTitle(String.termsOfServiceTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .white
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
        button.backgroundColor = .white
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
    
    private func setUpViews() {
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = false
        
        view.backgroundColor = .white
        
        view.addSubview(subscribeButton)
        view.addSubview(welcomeToChutePlusLabel)
        view.addSubview(autoRenewMessageLabel)
        view.addSubview(termsOfServiceButton)
        view.addSubview(privacyPolicyButton)
        
        subscribeButton.topAnchor.constraint(equalTo: welcomeToChutePlusLabel.topAnchor, constant: -75).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true

        welcomeToChutePlusLabel.topAnchor.constraint(equalTo: autoRenewMessageLabel.topAnchor, constant: -50).isActive = true
        welcomeToChutePlusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeToChutePlusLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        welcomeToChutePlusLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        autoRenewMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        autoRenewMessageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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
