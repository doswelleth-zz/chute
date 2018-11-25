//
//  LoginViewController.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

struct KeychainConfiguration {
    static let serviceName = "chute"
    static let accessGroup: String? = nil
}

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
        let hasLogin = UserDefaults.standard.bool(forKey: String.hasLoginKey)
        
        if hasLogin {
            signInButton.setTitle(String.signInButtonTitle, for: .normal)
            signInButton.tag = signInButtonTag
            touchIDButton.isHidden = false
            touchIDButton.isUserInteractionEnabled = true
        } else {
            signInButton.setTitle(String.signUpButtonTitle, for: .normal)
            signInButton.tag = signUpButtonTag
            touchIDButton.isHidden = true
            touchIDButton.isUserInteractionEnabled = false
        }
        
        if let username = UserDefaults.standard.value(forKey: String.username) as? String {
            usernameTextField.text = username
        }
        
        signInButton.addTarget(self, action: #selector(signInButtonTapped(sender:)), for: .touchUpInside)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        hideKeyboardWhenTappedAround()
    }
    
    var context: NSManagedObjectContext?
    
    var passwordItems: [KeychainPasswordItem] = []
    let signUpButtonTag = 0
    let signInButtonTag = 1
    
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
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: -0.3))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.usernamePlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.tintColor = .black
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(string: String.passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.signInButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.5
        button.backgroundColor = Appearance.customBackground
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // TODO: Firebase auth code - right now, only works with Core data
    
//    @objc private func signInButtonTap(sender: UIButton) {
//
//        guard let email = usernameTextField.text, let password = passwordTextField.text else
//        { return }
//
//        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
//            if let error = error {
//                NSLog("Error authenticating user: \(error)")
//            }
//            guard let user = authResult?.user else { return }
//            self.usernameTextField.text! = user.displayName ?? "User"
//            self.presentWelcomeViewController()
//        }
//    }
    
    @objc private func signInButtonTapped(sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = true
        
        guard let newAccountName = usernameTextField.text,
            let newPassword = passwordTextField.text, !newAccountName.isEmpty,
            !newPassword.isEmpty else {
                showLoginFailedAlert()
                return
        }
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if sender.tag == signUpButtonTag {
            let hasLoginKey = UserDefaults.standard.bool(forKey: String.hasLoginKey)
            
            if !hasLoginKey && (usernameTextField.hasText) {
                UserDefaults.standard.setValue(usernameTextField.text, forKey: String.username)
            }
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: newAccountName,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                try passwordItem.savePassword(newPassword)
            } catch let error {
                NSLog("Error saving password:\(error.localizedDescription)")
            }
            
            UserDefaults.standard.set(true, forKey: String.hasLoginKey)
            signInButton.tag = signInButtonTag
            presentShopTableViewController()
        } else if sender.tag == signInButtonTag {
            if checkLogin(username: newAccountName, password: newPassword) {
                presentShopTableViewController()
            } else {
                showLoginFailedAlert()
            }
        }
        saveUserCredentials()
    }
    
    private func checkLogin(username: String, password: String) -> Bool {
        guard username == UserDefaults.standard.value(forKey: String.username) as? String else {
            return false
        }
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        } catch let error {
            NSLog("Error reading password from keychain\(error.localizedDescription)")
        }
        return true
    }
    
    private func showLoginFailedAlert() {
        let alertView = UIAlertController(title: String.loginFailAlertTitle, message: String.loginFailAlertMessageTitle, preferredStyle:. alert)
        let okAction = UIAlertAction(title: String.loginFailActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    private func presentEmptyFieldsAlert() {
        let alert = UIAlertController(title: String.alertTitle, message: String.messageTitle, preferredStyle: .alert)
        let action = UIAlertAction(title: String.actionTitle, style: .default) { (action) in
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func saveUserCredentials() {
        let context = CoreDataStack.shared.mainContext
        let entity = NSEntityDescription.entity(forEntityName: "Chute", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(usernameTextField.text!, forKey: String.username)
        newUser.setValue(passwordTextField.text!, forKey: String.password)
        
        do {
            try context.save()
        } catch {
            NSLog("Failed saving user credentials: \(error)")
        }
    }
    
    private func presentShopTableViewController() {
        let vc = DashboardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // Touch ID
    
    let touchIDButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.touchIDTitle, for: .normal)
        button.setTitleColor(Appearance.customBackground, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = Appearance.customBackground.cgColor
        button.layer.borderWidth = 1.5
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(touchIDButtonTapped(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let touch = BiometricIDAuth()
    
    @objc private func touchIDButtonTapped(sender: UIButton) {
        self.navigationController?.navigationBar.isHidden = true
        
        touch.authenticateUser() { [weak self] message in
            if let message = message {
                let alert = UIAlertController(title: self?.touchIDAlertTitle, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: self?.touchIDActionTitle, style: .default)
                alert.addAction(action)
                self?.present(alert, animated: true)
            } else {
                self?.presentShopTableViewController()
            }
        }
    }
    
    private func setUpViews() {
        
        view.backgroundColor = Appearance.lightBackground
        
        touchIDButton.isHidden = !touch.canEvaluatePolicy()
        
        view.addSubview(logoLabel)
        view.addSubview(logoSubtitle)
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(touchIDButton)
    
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        logoSubtitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoSubtitle.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 10).isActive = true
        logoSubtitle.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        logoSubtitle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        usernameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: logoSubtitle.bottomAnchor, constant: 50).isActive = true
        usernameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        touchIDButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        touchIDButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 30).isActive = true
        touchIDButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
        touchIDButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Touch ID - Private
    
    private let touchIDAlertTitle = "Error"
    private let touchIDActionTitle = "Okay"
}
