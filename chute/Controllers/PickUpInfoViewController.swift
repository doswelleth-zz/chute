//
//  PickUpInfoViewController.swift
//  chute
//
//  Created by David Doswell on 9/28/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class PickUpInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
    }
    
    let faqLabel: UILabel = {
        let label = UILabel()
        label.text = String.faqLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 75)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let onboardTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Appearance.customBackground
        textView.text = String.onboardingInfo
        textView.textColor = .white
        textView.textAlignment = .justified
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isScrollEnabled = true
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Appearance.customBackground
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTap(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func doneButtonTap(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        
        view.addSubview(faqLabel)
        view.addSubview(onboardTextView)
        view.addSubview(doneButton)
       
        faqLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        faqLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faqLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        faqLabel.heightAnchor.constraint(equalToConstant: 76).isActive = true
        
        onboardTextView.topAnchor.constraint(equalTo: faqLabel.bottomAnchor, constant: 20).isActive = true
        onboardTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardTextView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        onboardTextView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        doneButton.topAnchor.constraint(equalTo: onboardTextView.bottomAnchor, constant: 40).isActive = true
        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 125).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }

}
