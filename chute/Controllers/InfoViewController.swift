//
//  InfoViewController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let buttonColor = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 255.0/255.0, alpha: 1.0)

class InfoViewController: UIViewController {
    
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
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(String.backButton, for: .normal)
        button.setTitleColor(buttonColor, for: .normal)
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
    
    let onboardTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = String.onboardingInfo
        textView.textColor = .black
        textView.textAlignment = .justified
        textView.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight(rawValue: -0.3))
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let faqLabel: UILabel = {
        let label = UILabel()
        label.text = String.faqLabelText
        label.textAlignment = .center
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1.0))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    func setUpViews() {
        view.backgroundColor = Appearance.lightBackground

        view.addSubview(backButton)
        view.addSubview(chuteImageView)
        view.addSubview(onboardTextView)
        view.addSubview(faqLabel)
        
        onboardTextView.showsVerticalScrollIndicator = false
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30.0).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        faqLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 20.0).isActive = true
        faqLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        faqLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        
        onboardTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        onboardTextView.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        onboardTextView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
    }
}
