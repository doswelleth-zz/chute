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
    
    let dressShirtsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 25.0
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1.0
        return image
    }()
    
    private func setUpViews() {
        backgroundColor = .black
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        
        addSubview(dressShirtsImageView)
        
        dressShirtsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 44.0).isActive = true
        dressShirtsImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0).isActive = true
        dressShirtsImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 50.0).isActive = true
        dressShirtsImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: 50.0).isActive = true
        
    }
}
