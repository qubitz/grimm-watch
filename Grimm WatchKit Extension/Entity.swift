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
    var area: Area
    
    init(at location: WorldLocation, with items: [Item], parent: Area) {
        self.location = location
        self.inventory = items
        self.area = parent
    }
    
    func move(in direction: Direction) {
        switch direction {
        case .down:
            location.area += (0, 0, -1)
        default:
            break
        }
    }
    
    func move(to destination: WorldLocation) {
        location = destination
    }
}
