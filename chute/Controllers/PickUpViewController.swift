//
//  PickUpViewController.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit
import UserNotifications

private let reuseIdentifier = "reuseIdentifier"
private let navigationTitle = "Pick Ups"

class PickUpViewController: UIViewController {

    let pickUpController = PickUpController()
    var sortedPickUps: [PickUp] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.sortedPickUps = self.pickUpController.pickUps.sorted(by: {$0.timestamp > $1.timestamp})
            self.pickUpController.decode()
            self.collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let pickUpVC = UICollectionView(frame: .zero, collectionViewLayout: layout)
        pickUpVC.backgroundColor = .white
        pickUpVC.alwaysBounceVertical = true
        pickUpVC.showsVerticalScrollIndicator = false
        return pickUpVC
    }()
    
    private func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpNavBar()
        
        self.title = navigationTitle
        
        DispatchQueue.main.async {
            self.sortedPickUps = self.pickUpController.pickUps.sorted(by: { $0.timestamp > $1.timestamp })
            self.pickUpController.decode()
            self.collectionView.reloadData()
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PickUpCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setUpNavBar() {
        let right = UIButton(type: .custom)
        right.setImage(UIImage(named: "PickUp"), for: .normal)
        right.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        right.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        right.contentMode = .scaleAspectFill
        right.adjustsImageWhenHighlighted = false
        right.addTarget(self, action: #selector(rightBarButtonTap(sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: right)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func rightBarButtonTap(sender: UIButton) {
        let vc = PickUpDetailViewController()
        vc.pickUpController = pickUpController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension PickUpViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return sortedPickUps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PickUpCell
        
        let pickUp = sortedPickUps[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        cell.timeStampLabel.text = formatter.string(from: pickUp.timestamp)
        cell.nameLabel.text = pickUp.name
        cell.quantityLabel.text = pickUp.quantity
        cell.hasChuteBagLabel.text = pickUp.hasChuteBag
        cell.hasChuteExpressLabel.text = pickUp.hasExpress
        cell.identifierLabel.text = pickUp.identifier
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pickUp = sortedPickUps[indexPath.item]
        
        let alert = UIAlertController(title: "Delete", message: "Permanently delete your order?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (actio) in
            
            DispatchQueue.main.async {
                self.pickUpController.delete(pickUp: pickUp)
                self.sortedPickUps = self.pickUpController.pickUps.sorted(by: { $0.timestamp > $1.timestamp })
                
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
        
        return CGSize(width: 0, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize(width: 0, height: 30)
    }
}

extension PickUpViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30.0
    }
}
