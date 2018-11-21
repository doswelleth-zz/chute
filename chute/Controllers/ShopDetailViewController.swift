//
//  ShopDetailViewController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

class ShopDetailViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        self.title = "Checkout"
        hideKeyboardWhenTappedAround()
        
        self.tabBarController?.delegate = self
    }
    
    let order: Order? = nil
    var ordersController: OrdersController?
    
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
        textField.attributedPlaceholder = NSAttributedString(string: "Type (laundry, dry cleaning)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
        textField.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.3))
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
    
    let scheduleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Schedule (one-time, weekly)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "City State and Zip", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.tintColor = .black
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
        if nameTextField.text!.isEmpty || addressTextField.text!.isEmpty || cityStateZipTextField.text!.isEmpty || typeTextField.text!.isEmpty || hasChuteBagTextField.text!.isEmpty || scheduleTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let name = nameTextField.text, let address = addressTextField.text, let cityStateZip = cityStateZipTextField.text, let type = typeTextField.text, let hasChuteBag = hasChuteBagTextField.text, let schedule = scheduleTextField.text, let identifier = identifierLabel.text else { return }
            
            ordersController?.createOrder(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: Date())
            
            ordersController?.createFirebaseOrder(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: Date(), completion: { (error) in
                if let error = error {
                    NSLog("Error occured while creating a pickup: \(error)")
                }
            })
            
            // TODO: IN APP PURCHASE
            
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
        let vc = OrdersViewController()
        guard let ordersController = ordersController else { return }
        vc.ordersController = ordersController
        navigationController?.popViewController(animated: true)
    }
    
    func setUpViews() {
        view.backgroundColor = .white
            
        view.addSubview(timeStampLabel)
        view.addSubview(nameTextField)
        view.addSubview(typeTextField)
        view.addSubview(hasChuteBagTextField)
        view.addSubview(scheduleTextField)
        view.addSubview(addressTextField)
        view.addSubview(cityStateZipTextField)
        view.addSubview(identifierLabel)
        view.addSubview(payButton)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        nameTextField.delegate = self
        typeTextField.delegate = self
        hasChuteBagTextField.delegate = self
        scheduleTextField.delegate = self
        addressTextField.delegate = self
        cityStateZipTextField.delegate = self
        
        timeStampLabel.text = formatter.string(from: date)
        
        timeStampLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        timeStampLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
       
        nameTextField.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        addressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        addressTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        cityStateZipTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 20).isActive = true
        cityStateZipTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        cityStateZipTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cityStateZipTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        typeTextField.topAnchor.constraint(equalTo: cityStateZipTextField.bottomAnchor, constant: 20).isActive = true
        typeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        typeTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        typeTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        hasChuteBagTextField.topAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 20).isActive = true
        hasChuteBagTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hasChuteBagTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hasChuteBagTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        scheduleTextField.topAnchor.constraint(equalTo: hasChuteBagTextField.bottomAnchor, constant: 20).isActive = true
        scheduleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        scheduleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        scheduleTextField.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: scheduleTextField.bottomAnchor, constant: 30).isActive = true
        identifierLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        payButton.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 50).isActive = true
        payButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        payButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

