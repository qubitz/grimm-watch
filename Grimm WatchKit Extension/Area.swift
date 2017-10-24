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
    
    init(withItems items: [String], andDesc desc: String) {
        for (index, item) in items.enumerated() {
            inventory[index] = Item(item)
        }
        
        description = desc
    }
}
