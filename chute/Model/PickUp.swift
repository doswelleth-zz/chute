//
//  PickUp.swift
//  chute
//
//  Created by David Doswell on 9/27/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

struct PickUp: Codable, Equatable {
    let name: String
    let address: String
    let cityStateZip: String
    let quantity: String
    let hasChuteBag: String
    let hasExpress: String
    let identifier: String
    let timestamp: Date
    
    static func ==(lhs: PickUp, rhs: PickUp) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
