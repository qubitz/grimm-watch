//
//  Entity.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/24/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Entity: Codable {
    var inventory = [Item]()
    var location: WorldLocation
    
    init(spawnAt location: WorldLocation, with items: [Item]) {
        self.location = location
        self.inventory = items
    }
}
