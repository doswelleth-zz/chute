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
        
        self.orderNowImage.alpha = 0
        self.ordersButton.alpha = 0
        self.faqButton.alpha = 0
        
        UIView.animate(withDuration: 1.0) {
            self.orderNowImage.alpha = 1.0
            self.ordersButton.alpha = 1.0
            self.faqButton.alpha = 1.0
        }
    }
    
    private var popGesture: UIGestureRecognizer?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if navigationController!.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.popGesture = navigationController!.interactivePopGestureRecognizer
            self.navigationController!.view.removeGestureRecognizer(navigationController!.interactivePopGestureRecognizer!)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let gesture = self.popGesture {
            self.navigationController!.view.addGestureRecognizer(gesture)
        }
        
    }
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = String.logoLabelText
        label.textColor = Appearance.customBackground
        label.textAlignment = .center
        label.font = UIFont(name: String.logoLabelFont, size: 75)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoSubtitle: UILabel = {
        let label = UILabel()
        label.text = String.logoSubtitleText
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dashboardLabel: UILabel = {
        let label = UILabel()
        label.text = String.dashboardTitle
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight(rawValue: 1.0))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderNowImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Shop")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.orderNowButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = Appearance.customBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight(rawValue: -0.2))
        button.addTarget(self, action: #selector(orderNowButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func orderNowButtonTapped(sender: UIButton) {
        let vc = ShopViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let ordersImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Orders")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let ordersButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.ordersButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = Appearance.customBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight(rawValue: -0.2))
        button.addTarget(self, action: #selector(ordersButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func ordersButtonTapped(sender: UIButton) {
        let vc = OrdersViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let faqImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "FAQ")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let faqButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.faqButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = Appearance.customBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight(rawValue: -0.2))
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
        view.backgroundColor = Appearance.lightBackground
        
        view.addSubview(logoLabel)
        view.addSubview(logoSubtitle)
        view.addSubview(dashboardLabel)
        
        view.addSubview(orderNowImage)
        view.addSubview(orderButton)
        view.addSubview(ordersImage)
        view.addSubview(ordersButton)
        view.addSubview(faqImage)
        view.addSubview(faqButton)
        
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        logoSubtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoSubtitle.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10).isActive = true
        logoSubtitle.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        logoSubtitle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        dashboardLabel.topAnchor.constraint(equalTo: logoSubtitle.bottomAnchor, constant: 40).isActive = true
        dashboardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dashboardLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        dashboardLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        
        orderNowImage.topAnchor.constraint(equalTo: dashboardLabel.bottomAnchor, constant: 30.0).isActive = true
        orderNowImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50.0).isActive = true
        orderNowImage.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        orderNowImage.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        orderButton.topAnchor.constraint(equalTo: orderNowImage.bottomAnchor, constant: 10.0).isActive = true
        orderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40.0).isActive = true
        orderButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        orderButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        ordersImage.topAnchor.constraint(equalTo: dashboardLabel.bottomAnchor, constant: 30.0).isActive = true
        ordersImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40.0).isActive = true
        ordersImage.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        ordersImage.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        ordersButton.topAnchor.constraint(equalTo: ordersImage.bottomAnchor, constant: 10.0).isActive = true
        ordersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30.0).isActive = true
        ordersButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        ordersButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        faqImage.topAnchor.constraint(equalTo: ordersButton.bottomAnchor, constant: 30.0).isActive = true
        faqImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqImage.widthAnchor.constraint(equalToConstant: 75.0).isActive = true
        faqImage.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        faqButton.topAnchor.constraint(equalTo: faqImage.bottomAnchor, constant: 10.0).isActive = true
        faqButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqButton.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        faqButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }

}
