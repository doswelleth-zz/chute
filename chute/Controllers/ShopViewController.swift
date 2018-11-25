//
//  ShopViewController.swift
//  chute
//
//  Created by David Doswell on 11/21/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"
private let buttonColor = UIColor(red: 135.0/255.0, green: 206.0/255.0, blue: 255.0/255.0, alpha: 1.0)

class ShopViewController: UIViewController {
    
    var cellImages: [String] = ["Wash", "Wash", "Wash"]
    var cellLabels: [String] = ["Small - 1 Chute Bag, 2-3 days", "Medium - 1 Chute Bag, 2-3 days", "Large - 1 Chute Bag, 2-3 days"]
    var cellDetails: [String] = ["$15.00", "$20.00", "$23.00"]
    
    let ordersController = OrdersController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        setUpViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Appearance.lightBackground

        collectionView.alwaysBounceVertical = true
        collectionView.register(ShopCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let shopVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        shopVC.showsVerticalScrollIndicator = false
        return shopVC
    }()
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Appearance.lightBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private func setUpViews() {
        view.backgroundColor = Appearance.lightBackground
        
        view.addSubview(containerView)
        containerView.addSubview(chuteImageView)
        view.addSubview(backButton)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
}

extension ShopViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellLabels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShopCell
        
        cell.imageView.image = UIImage(named: cellImages[indexPath.item])
        cell.textLabel.text = cellLabels[indexPath.item]
        cell.detailTextLabel.text = cellDetails[indexPath.item]
        cell.textLabel.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ShopDetailViewController()
        vc.ordersController = ordersController
        
        let sizeImageLabel = cellLabels[indexPath.row]
        vc.typeTextField.text = sizeImageLabel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30.0
    }
}
