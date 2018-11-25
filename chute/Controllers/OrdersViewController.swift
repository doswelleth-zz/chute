//
//  OrdersViewController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

private let reuseIdentifier = "reuseIdentifier"

class OrdersViewController: UIViewController {

    var ordersController = OrdersController()
    var sortedOrders: [Order] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.sortedOrders = self.ordersController.orders.sorted(by: {$0.timestamp > $1.timestamp})
            self.ordersController.decode()
            self.collectionView.reloadData()
        }
        self.ordersLabel.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            self.ordersLabel.alpha = 1.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpViews()
        
        self.sortedOrders = self.ordersController.orders.sorted(by: { $0.timestamp > $1.timestamp })
        self.ordersController.decode()
        self.collectionView.reloadData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = Appearance.lightBackground
        collectionView.register(OrdersCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let ordersVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        ordersVC.alwaysBounceVertical = true
        ordersVC.showsVerticalScrollIndicator = false
        return ordersVC
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
        button.setTitleColor(Appearance.customBackground, for: .normal)
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
    
    let ordersLabel: UILabel = {
        let label = UILabel()
        label.text = "List of Orders"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0, weight: UIFont.Weight(rawValue: 1.0))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setUpViews() {
        view.backgroundColor = Appearance.customBackground
        view.addSubview(containerView)
        view.addSubview(backButton)
        containerView.addSubview(chuteImageView)
        containerView.addSubview(ordersLabel)
        
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 130.0).isActive = true
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        chuteImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50.0).isActive = true
        chuteImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chuteImageView.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        chuteImageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        ordersLabel.topAnchor.constraint(equalTo: chuteImageView.bottomAnchor, constant: 30.0).isActive = true
        ordersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ordersLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        ordersLabel.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
    }
}

extension OrdersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OrdersCell
        
        let order = sortedOrders[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.timeStampLabel.text = formatter.string(from: order.timestamp)
        cell.nameLabel.text = order.name
        cell.addressLabel.text = order.address
        cell.cityStateZipLabel.text = order.cityStateZip
        cell.typeLabel.text = order.type
        cell.hasChuteBagLabel.text = order.hasChuteBag
        cell.scheduleLabel.text = order.schedule
        cell.identifierLabel.text = order.identifier
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let order = sortedOrders[indexPath.item]
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete your order?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            DispatchQueue.main.async {
                self.ordersController.delete(order: order)
                self.ordersController.deleteFirebaseOrder(order: order, completion: { (error) in
                    if let error = error {
                        
                        NSLog("Error deleting pick up \(error)")
                    }
                })
                self.sortedOrders = self.ordersController.orders.sorted(by: { $0.timestamp > $1.timestamp })
                
                self.collectionView.reloadData()
            }
            self.sendNotification()
        }
        let no = UIAlertAction(title: "No", style: .default) { (action) in }
        
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true, completion: nil)
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "WE DELETED YOUR ORDER 🛎"
        content.body = "See you, again, soon!"
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 150.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30.0)
    }
}

extension OrdersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 350.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20.0
    }
}

