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
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date = Date()
    let formatter = DateFormatter()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hasChuteBagLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let hasChuteExpressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.isUserInteractionEnabled = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.text = UUID().uuidString
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func notifyUser() {
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(notifyUserFunction), name: Notification.Name(rawValue: String.notification), object: nil)
    }
    
    @objc private func notifyUserFunction() {
        let _ = AudioServicesPlaySystemSound(1027)
        let _ = AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    func setUpViews() {
        backgroundColor = .white
        addSubview(timeStampLabel)
        addSubview(nameLabel)
        addSubview(quantityLabel)
        addSubview(hasChuteBagLabel)
        addSubview(hasChuteExpressLabel)
        addSubview(identifierLabel)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        
        formatter.timeStyle = .medium
        formatter.dateStyle = .medium
        timeStampLabel.text = formatter.string(from: date)
        
        timeStampLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        timeStampLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeStampLabel.widthAnchor.constraint(equalToConstant: frame.size.width).isActive = true
        timeStampLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: timeStampLabel.bottomAnchor, constant: 20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        quantityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        quantityLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        quantityLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        quantityLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        hasChuteBagLabel.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 20).isActive = true
        hasChuteBagLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        hasChuteBagLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        hasChuteBagLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        hasChuteExpressLabel.topAnchor.constraint(equalTo: hasChuteBagLabel.bottomAnchor, constant: 20).isActive = true
        hasChuteExpressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        hasChuteExpressLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        hasChuteExpressLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        identifierLabel.topAnchor.constraint(equalTo: hasChuteExpressLabel.bottomAnchor, constant: 20).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        identifierLabel.widthAnchor.constraint(equalToConstant: 350).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
}
