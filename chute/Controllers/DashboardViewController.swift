//
//  DashboardViewController.swift
//  chute
//
//  Created by David Doswell on 11/21/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setUpViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.shopButton.alpha = 0
        self.ordersButton.alpha = 0
        self.subscribeButton.alpha = 0
        self.faqButton.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.shopButton.alpha = 1.0
            self.ordersButton.alpha = 1.0
            self.subscribeButton.alpha = 1.0
            self.faqButton.alpha = 1.0
        }
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ProfileBackground")
        image.contentMode = .scaleAspectFill
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
    
    let dashboardLabel: UILabel = {
        let label = UILabel()
        label.text = String.dashboardTitle
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: -0.2))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shopButton: UIButton = {
        let button = UIButton()
        button.setTitle(String.shopButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(shopButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func shopButtonTapped(sender: UIButton) {
        let vc = ShopTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let ordersButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(String.ordersButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(ordersButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func ordersButtonTapped(sender: UIButton) {
        let vc = OrdersViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let subscribeButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(String.subscribeButtonTitle2, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(subscribeButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func subscribeButtonTapped(sender: UIButton) {
        let vc = SubscribeViewController()
        self.navigationController?.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    let faqButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(String.faqButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(faqButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func faqButtonTapped(sender: UIButton) {
        let vc = InfoViewController()
        self.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(chuteImageView)
        view.addSubview(dashboardLabel)
        view.addSubview(shopButton)
        view.addSubview(ordersButton)
        view.addSubview(subscribeButton)
        view.addSubview(faqButton)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        dashboardLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 30).isActive = true
        dashboardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dashboardLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        dashboardLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        shopButton.topAnchor.constraint(equalTo: dashboardLabel.bottomAnchor, constant: 50).isActive = true
        shopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shopButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        shopButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        ordersButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: 30).isActive = true
        ordersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ordersButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ordersButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        subscribeButton.topAnchor.constraint(equalTo: ordersButton.bottomAnchor, constant: 30).isActive = true
        subscribeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subscribeButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        subscribeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        faqButton.topAnchor.constraint(equalTo: subscribeButton.bottomAnchor, constant: 30).isActive = true
        faqButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        faqButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
