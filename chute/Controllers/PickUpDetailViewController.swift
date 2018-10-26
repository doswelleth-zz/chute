//
//  PickUpDetailViewController.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

class PickUpDetailViewController: UIViewController, UITextFieldDelegate, UNUserNotificationCenterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpLeftNavBar()
        setUpRightNavBar()
        
        setUpViews()
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [. alert, .sound]) { (granted, error) in
            if let error = error {
                NSLog("There was an error requesting authorization: \(error)")
                return
            }
            NSLog("Notifications granted \(granted)")
        }
        
        self.title = "Order a Pick Up"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        hideKeyboardWhenTappedAround()
    }
    
    let pickUp: PickUp? = nil
    var pickUpController: PickUpController?
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "First & Last name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let typeTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Type (laundry, dry cleaning)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let hasChuteBagTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Have a Chute Bag?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let scheduleTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Schedule (one-time, weekly)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let cityStateZipTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "City State and Zip", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.tintColor = .white
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.text = UUID().uuidString
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.customBackground
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(scheduleButtonTap(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func scheduleButtonTap(sender: UIButton) {
        if nameTextField.text!.isEmpty || addressTextField.text!.isEmpty || cityStateZipTextField.text!.isEmpty || typeTextField.text!.isEmpty || hasChuteBagTextField.text!.isEmpty || scheduleTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let name = nameTextField.text, let address = addressTextField.text, let cityStateZip = cityStateZipTextField.text, let type = typeTextField.text, let hasChuteBag = hasChuteBagTextField.text, let schedule = scheduleTextField.text, let identifier = identifierLabel.text else { return }
            
            pickUpController?.createPickUp(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: Date())
            
            pickUpController?.createFirebasePickUp(with: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: Date(), completion: { (error) in
                if let error = error {
                    NSLog("Error occured while creating a pickup: \(error)")
                }
            })
            sendNotification()
        }
        presentPickUpViewController()
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
    
    private func presentPickUpViewController() {
        let vc = PickUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpLeftNavBar() {
        let left = UIButton(type: .custom)
        left.setTitleColor(.white, for: .normal)
        left.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        left.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        left.contentMode = .scaleAspectFill
        left.addTarget(self, action: #selector(leftBarButtonPop(sender:)), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(leftBarButtonPop(sender:)))
    }
    
    @objc private func leftBarButtonPop(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpRightNavBar() {
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "Subscribe"), for: .normal)
        right.layer.cornerRadius = 20
        right.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
    }
    
    @objc private func rightBarButtonTap(sender: UIButton) {
        let vc = SubscribeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        view.addSubview(timeStampLabel)
        view.addSubview(nameTextField)
        view.addSubview(typeTextField)
        view.addSubview(hasChuteBagTextField)
        view.addSubview(scheduleTextField)
        view.addSubview(addressTextField)
        view.addSubview(cityStateZipTextField)
        view.addSubview(identifierLabel)
        view.addSubview(scheduleButton)
        
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
        timeStampLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        addressTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        addressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        addressTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        addressTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        cityStateZipTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10).isActive = true
        cityStateZipTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        cityStateZipTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        cityStateZipTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        typeTextField.topAnchor.constraint(equalTo: cityStateZipTextField.bottomAnchor, constant: 10).isActive = true
        typeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        typeTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        typeTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        hasChuteBagTextField.topAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 10).isActive = true
        hasChuteBagTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hasChuteBagTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hasChuteBagTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scheduleTextField.topAnchor.constraint(equalTo: hasChuteBagTextField.bottomAnchor, constant: 10).isActive = true
        scheduleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        scheduleTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        scheduleTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: scheduleTextField.bottomAnchor, constant: 10).isActive = true
        identifierLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scheduleButton.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 50).isActive = true
        scheduleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scheduleButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        scheduleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
