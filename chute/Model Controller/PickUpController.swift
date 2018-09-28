//
//  PickUpController.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private var pickUpPList = "pickUpPList"

class PickUpController {
    
    private(set) var pickUps: [PickUp] = []
    
    func createPickUp(with name: String, quantity: String, hasChuteBag: String, hasExpress: String, identifier: String, timestamp: Date) {
        let pickUp = PickUp(name: name, quantity: quantity, hasChuteBag: hasChuteBag, hasExpress: hasExpress, identifier: identifier, timestamp: timestamp)
        pickUps.append(pickUp)
        encode()
    }
    
    func update(pickUp: PickUp) {
        guard let index = pickUps.index(of: pickUp) else { return }
        pickUps.remove(at: index)
        pickUps.append(pickUp)
        encode()
    }
    
    func delete(pickUp: PickUp) {
        guard let index = pickUps.index(of: pickUp) else { return }
        pickUps.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(pickUpPList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let pickUpData = try encoder.encode(pickUps)
            try pickUpData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let pickUpData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedPickUps = try decoder.decode([PickUp].self, from: pickUpData)
            pickUps = decodedPickUps
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
