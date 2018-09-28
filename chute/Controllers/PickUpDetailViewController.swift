//
//  PickUpDetailViewController.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

class PickUpDetailViewController: UIViewController, UITextFieldDelegate {
    
    let pickUp: PickUp? = nil
    var pickUpController: PickUpController?
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "First and Last name", attributes: [NSAttributedString.Key.foregroundColor: Appearance.customBackground])
        textField.tintColor = Appearance.customBackground
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let quantityTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Quantity", attributes: [NSAttributedString.Key.foregroundColor: Appearance.customBackground])
        textField.tintColor = Appearance.customBackground
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let hasChuteBagTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Have a Chute Bag?", attributes: [NSAttributedString.Key.foregroundColor: Appearance.customBackground])
        textField.tintColor = Appearance.customBackground
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let hasExpressTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(string: "Have Chute Express", attributes: [NSAttributedString.Key.foregroundColor: Appearance.customBackground])
        textField.tintColor = Appearance.customBackground
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.text = UUID().uuidString
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.customBackground
        button.layer.cornerRadius = 25
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(scheduleButtonTap(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let laundryImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PickUp")
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    @objc private func scheduleButtonTap(sender: UIButton) {
        if nameTextField.text!.isEmpty || quantityTextField.text!.isEmpty || hasChuteBagTextField.text!.isEmpty || hasExpressTextField.text!.isEmpty {
            let alert = UIAlertController(title: "Error", message: "Please enter all fields correctly", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            guard let name = nameTextField.text, let quantity = quantityTextField.text, let hasChuteBag = hasChuteBagTextField.text, let hasChuteExpress = hasExpressTextField.text, let identifier = identifierLabel.text else { return }
            
            pickUpController?.createPickUp(with: name, quantity: quantity, hasChuteBag: hasChuteBag, hasExpress: hasChuteExpress, identifier: identifier, timestamp: Date())
          
            sendNotification()

            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "YOU HAVE A NEW PICK UP 🎉"
        content.body = "Look for a text, soon!"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        self.title = "Schedule a Pick Up"
        self.navigationController?.navigationBar.tintColor = .white
        
        hideKeyboardWhenTappedAround()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(timeStampLabel)
        view.addSubview(nameTextField)
        view.addSubview(quantityTextField)
        view.addSubview(hasChuteBagTextField)
        view.addSubview(hasExpressTextField)
        view.addSubview(identifierLabel)
        view.addSubview(scheduleButton)
        view.addSubview(laundryImage)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        nameTextField.delegate = self
        quantityTextField.delegate = self
        hasChuteBagTextField.delegate = self
        hasExpressTextField.delegate = self
        
        timeStampLabel.text = formatter.string(from: date)
        
        timeStampLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        timeStampLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        quantityTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        quantityTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        quantityTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        quantityTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        hasChuteBagTextField.topAnchor.constraint(equalTo: quantityTextField.bottomAnchor, constant: 20).isActive = true
        hasChuteBagTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hasChuteBagTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hasChuteBagTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        hasExpressTextField.topAnchor.constraint(equalTo: hasChuteBagTextField.bottomAnchor, constant: 20).isActive = true
        hasExpressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        hasExpressTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        hasExpressTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: hasExpressTextField.bottomAnchor, constant: 20).isActive = true
        identifierLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        scheduleButton.topAnchor.constraint(equalTo: identifierLabel.bottomAnchor, constant: 30).isActive = true
        scheduleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scheduleButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        scheduleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        laundryImage.topAnchor.constraint(equalTo: scheduleButton.bottomAnchor, constant: 50).isActive = true
        laundryImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        laundryImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        laundryImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
