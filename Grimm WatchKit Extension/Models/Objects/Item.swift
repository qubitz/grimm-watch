//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Item: Codable {
    var name: String
    var health: Int
    
    init(_ name: String, health: Int = 100) {
        self.name = name
        self.health = health
    }
    
    func repair(by amount: Int) {
        health += amount
    }
    
    func hurt(by amount: Int = 10) {
        health -= amount
    }
}
