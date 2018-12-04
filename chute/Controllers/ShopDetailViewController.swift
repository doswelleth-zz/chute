//
//  ShopDetailViewController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

class ShopDetailViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        hideKeyboardWhenTappedAround()
        
        UNUserNotificationCenter.current().requestAuthorization(options: .alert) { (success, error) in
            if let error = error {
                NSLog("Notification request denied by user: \(error)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    var order: Order?
    var ordersController: OrdersController?
    
    let shopCell = ShopCell()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Appearance.lightBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.backButton, for: .normal)
        button.setTitleColor(Appearance.customBackground, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(backBarButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func backBarButtonTapped(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    let chuteImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Chute3")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: -0.1))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "First & Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let typeTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Type (small, medium, etc.)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.1))
        textField.isUserInteractionEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let hasChuteBagTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Have a Chute Bag?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let cityStateZipTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "City State and Zip", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.text = UUID().uuidString
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: -0.1))
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let payButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.customBackground
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.setTitle("Pay", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(payButtonTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func payButtonTap(sender: UIButton) {
        if nameTextField.text!.isEmpty || addressTextField.text!.isEmpty || cityStateZipTextField.text!.isEmpty || typeTextField.text!.isEmpty || hasChuteBagTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let name = nameTextField.text, let address = addressTextField.text, let cityStateZip = cityStateZipTextField.text, let type = typeTextField.text, let hasChuteBag = hasChuteBagTextField.text, let identifier = identifierLabel.text else { return }
            
            ordersController?.createOrder(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, identifier: identifier, timestamp: Date())
            
            ordersController?.createFirebaseOrder(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, identifier: identifier, timestamp: Date(), completion: { (error) in
                if let error = error {
                    NSLog("Error occured while creating a pickup: \(error)")
                }
            })
            
            // TODO: Uncomment once StoreKit is implemented
            
//            IAPHelper.shared.purchase(product: .consumableSubscription)
            
            sendNotification()
        }
        popViewController()
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "YOU HAVE A NEW PICK UP 🎉"
        content.body = "🚚 We're on our way!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Notification ID", content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                NSLog("Error scheduling notification \(error)")
                return
            }
        }
    }
    
    private func popViewController() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    let scrollView = UIScrollView(frame: UIScreen.main.bounds)

    func setUpViews() {
        view.backgroundColor = Appearance.lightBackground
        
        scrollView.isScrollEnabled = true
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.isUserInteractionEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 800)
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        scrollView.addSubview(backButton)
        scrollView.addSubview(chuteImageView)
        scrollView.addSubview(timeStampLabel)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(typeTextField)
        scrollView.addSubview(hasChuteBagTextField)
        scrollView.addSubview(addressTextField)
        scrollView.addSubview(cityStateZipTextField)
        scrollView.addSubview(identifierLabel)
        scrollView.addSubview(payButton)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        nameTextField.delegate = self
        typeTextField.delegate = self
        hasChuteBagTextField.delegate = self
        addressTextField.delegate = self
        cityStateZipTextField.delegate = self
        
        timeStampLabel.text = formatter.string(from: date)
        
        view.addSubview(containerView)
        containerView.addSubview(chuteImageView)
        view.addSubview(backButton)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        timeStampLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 30).isActive = true
        timeStampLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 17.0).isActive = true
       
        nameTextField.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20.0).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20.0).isActive = true
        addressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        addressTextField.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        
        cityStateZipTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20.0).isActive = true
        cityStateZipTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        cityStateZipTextField.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        cityStateZipTextField.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        
        typeTextField.topAnchor.constraint(equalTo: cityStateZipTextField.bottomAnchor, constant: 20.0).isActive = true
        typeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0).isActive = true
        typeTextField.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        typeTextField.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        
        hasChuteBagTextField.topAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 20.0).isActive = true
        hasChuteBagTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hasChuteBagTextField.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        hasChuteBagTextField.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: hasChuteBagTextField.bottomAnchor, constant: 30.0).isActive = true
        identifierLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        
        payButton.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 50.0).isActive = true
        payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payButton.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}

