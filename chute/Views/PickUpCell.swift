//
//  PickUpCell.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import AudioToolbox
import UserNotifications

class PickUpCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date = Date()
    let formatter = DateFormatter()
    
    let nameConstantLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeConstantLabel: UILabel = {
        let label = UILabel()
        label.text = "Quantity"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hasChuteBagConstantLabel: UILabel = {
        let label = UILabel()
        label.text = "Has a Chute Bag"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hasChuteBagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleConstantLabel: UILabel = {
        let label = UILabel()
        label.text = "Has Chute Express"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.text = UUID().uuidString
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        backgroundColor = Appearance.customBackground
        addSubview(timeStampLabel)
        addSubview(nameConstantLabel)
        addSubview(nameLabel)
        addSubview(typeConstantLabel)
        addSubview(typeLabel)
        addSubview(hasChuteBagConstantLabel)
        addSubview(hasChuteBagLabel)
        addSubview(scheduleConstantLabel)
        addSubview(scheduleLabel)
        addSubview(identifierLabel)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.cgColor
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        timeStampLabel.text = formatter.string(from: date)
        
        timeStampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        timeStampLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        nameConstantLabel.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameConstantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nameConstantLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        nameConstantLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        typeConstantLabel.topAnchor.constraint(equalTo: nameConstantLabel.bottomAnchor, constant: 20).isActive = true
        typeConstantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        typeConstantLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        typeConstantLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        typeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        typeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        hasChuteBagConstantLabel.topAnchor.constraint(equalTo: typeConstantLabel.bottomAnchor, constant: 20).isActive = true
        hasChuteBagConstantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        hasChuteBagConstantLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        hasChuteBagConstantLabel.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        hasChuteBagLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 20).isActive = true
         hasChuteBagLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        hasChuteBagLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        hasChuteBagLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        scheduleConstantLabel.topAnchor.constraint(equalTo: hasChuteBagConstantLabel.bottomAnchor, constant: 20).isActive = true
        scheduleConstantLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        scheduleConstantLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        scheduleConstantLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        scheduleLabel.topAnchor.constraint(equalTo: hasChuteBagLabel.bottomAnchor, constant: 20).isActive = true
        scheduleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
        scheduleLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        scheduleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: 20).isActive = true
        identifierLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 10).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
