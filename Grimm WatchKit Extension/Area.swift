//
//  Area.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Area: Codable {
    var description: String
    var inventory = [Item]()
    var walls: [Direction]
    
    init(withItems items: [Item], andDesc desc: String, walls: [Direction] = []) {
        for (index, item) in items.enumerated() {
            inventory[index] = item
        }
        
        description = desc
        self.walls = walls
    }
    
    func areasAvail() -> [Direction] {
        return Direction.invert(walls)
    }
}
