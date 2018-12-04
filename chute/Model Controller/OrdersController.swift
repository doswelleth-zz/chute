//
//  OrdersController.swift
//  chute
//
//  Created by David Doswell on 11/19/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private var ordersPList = "ordersPList"

class OrdersController {
    
    private(set) var orders: [Order] = []

    func createOrder(with name: String, address: String, cityStateZip: String, type: String, hasChuteBag: String, identifier: String, timestamp: Date) {
        
        let order = Order(name: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, identifier: identifier, timestamp: timestamp)
        orders.append(order)
        encode()
    }
    
    func delete(order: Order) {
        guard let index = orders.index(of: order) else { return }
        orders.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(ordersPList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let orderData = try encoder.encode(orders)
            try orderData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let orderData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedOrders = try decoder.decode([Order].self, from: orderData)
            orders = decodedOrders
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
    
    static let baseURL = URL(string: "https://chute-59259.firebaseio.com/")!
    
    func put(order: Order, completion: @escaping (Error?) -> Void) {
        
        let url = OrdersController.baseURL.appendingPathComponent(order.identifier).appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.put.rawValue
        
        do {
            request.httpBody = try JSONEncoder().encode(order)
        } catch {
            NSLog("Unable to encode \(order): \(error)")
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
    
    func createFirebaseOrder(with name: String, address: String, cityStateZip: String, type: String, hasChuteBag: String, identifier: String, timestamp: Date, completion: @escaping (Error?) -> Void) {
        
        let order = Order(name: name, address: address, cityStateZip: cityStateZip, type: type, hasChuteBag: hasChuteBag, identifier: identifier, timestamp: timestamp)
        
        // Pass in completion of createFirebaseOrder() into the completion closure of pull() - this will forward the completion of put() to the caller of createFirebaseOrder() so the error can be handled there.
        
        put(order: order, completion: completion)
    }
    
    // Fetch the data using GET
    func fetchFirebaseOrders(completion: @escaping (Error?) -> Void) {
        let url = OrdersController.baseURL.appendingPathExtension("json")
        
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
                let decodedOrders = try JSONDecoder().decode([String: Order].self, from: data)
                let sortedDecodedOrders = decodedOrders.map { $0.value }.sorted { $0.timestamp < $1.timestamp }
                
                DispatchQueue.main.async {
                    self.orders = sortedDecodedOrders
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
    
    func deleteFirebaseOrder(order: Order, completion: @escaping (Error?) -> Void) {
        
        let url = OrdersController.baseURL.appendingPathComponent(order.identifier).appendingPathExtension("json")
        
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
