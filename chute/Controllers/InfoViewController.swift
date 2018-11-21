//
//  InfoViewController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

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
    
    let faqImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "FAQBackground")
        image.contentMode = .scaleAspectFill
        image.alpha = 0.8
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
    
    let faqLabel: UILabel = {
        let label = UILabel()
        label.text = String.faqLabelText
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let onboardTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = String.onboardingInfo
        textView.textColor = .white
        textView.textAlignment = .justified
        textView.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.2))
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let ceoLabel: UILabel = {
        let label = UILabel()
        label.text = String.ceoLabelTitle
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(rawValue: -0.2))
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
        view.backgroundColor = .white
        
        view.addSubview(faqImageView)
        view.addSubview(chuteImageView)
        view.addSubview(faqLabel)
        view.addSubview(onboardTextView)
        view.addSubview(ceoLabel)
        
        onboardTextView.showsVerticalScrollIndicator = false
        
        faqImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        faqImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        faqImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        faqLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 20.0).isActive = true
        faqLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        faqLabel.heightAnchor.constraint(equalToConstant: 27.0).isActive = true
        
        onboardTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        onboardTextView.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        onboardTextView.heightAnchor.constraint(equalToConstant: 400.0).isActive = true
        
        ceoLabel.topAnchor.constraint(equalTo: onboardTextView.bottomAnchor, constant: 15.0).isActive = true
        ceoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ceoLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        ceoLabel.heightAnchor.constraint(equalToConstant: 19.0).isActive = true
    }
}
