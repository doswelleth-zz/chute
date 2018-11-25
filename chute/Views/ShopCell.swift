//
//  ShopCell.swift
//  chute
//
//  Created by David Doswell on 11/21/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight(-0.3))
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(-0.3))
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpViews() {
        backgroundColor = Appearance.lightBackground

        addSubview(imageView)
        addSubview(textLabel)
        addSubview(detailTextLabel)
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30.0).isActive = true
        textLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20.0).isActive = true
        textLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        detailTextLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10.0).isActive = true
        detailTextLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20.0).isActive = true
        detailTextLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        detailTextLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
}
