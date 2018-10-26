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
    
    func createPickUp(with name: String, address: String, cityStateZip: String, type: String, hasChuteBag: String, schedule: String, identifier: String, timestamp: Date) {
        
        let pickUp = PickUp(name: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: timestamp)
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
    
    private enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    static let baseURL = URL(string: "https://chute-939fc.firebaseio.com/")!
    
    func put(pickUp: PickUp, completion: @escaping (Error?) -> Void) {
        
        let url = PickUpController.baseURL.appendingPathComponent(pickUp.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(pickUp)
        } catch {
            NSLog("Unable to encode \(pickUp): \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error saving entry to server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
    
    // Create a new pick up using the PUT method above
    
    func createFirebasePickUp(with name: String, address: String, cityStateZip: String, type: String, hasChuteBag: String, schedule: String, identifier: String, timestamp: Date, completion: @escaping (Error?) -> Void) {
        
        let pickUp = PickUp(name: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, schedule: schedule, identifier: identifier, timestamp: timestamp)
        
        // Pass in completion of createFirebasePickUp() into the completion closure of pull() - this will forward the completion of put() to the caller of createFirebasePickUp() so the error can be handled there.
        
        put(pickUp: pickUp, completion: completion)
    }
    
    // Fetch the data using GET
    func fetchFirebasePickUps(completion: @escaping (Error?) -> Void) {
        let url = PickUpController.baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving entries from server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            
            do {
                let decodedEntries = try JSONDecoder().decode([String: PickUp].self, from: data)
                let sortedDecodedEntries = decodedEntries.map { $0.value }.sorted { $0.timestamp < $1.timestamp }
                
                DispatchQueue.main.async {
                    self.pickUps = sortedDecodedEntries
                    completion(nil)
                }
            } catch {
                NSLog("Error decoding received data: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
        }.resume()
    }
    
    func deleteFirebasePickUp(pickUp: PickUp, completion: @escaping (Error?) -> Void) {
        
        let url = PickUpController.baseURL.appendingPathComponent(pickUp.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error deleting entry from server: \(error)")
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(nil)
            }
        }.resume()
    }
}


