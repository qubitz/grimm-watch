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
        var destination = self.location
        destination.area += direction.unitVec
        move(to: destination)
    }
    
    func move(to destination: WorldLocation) {
        area.move(self, to: destination)
    }
    
    func pickupItem(at index: Int) {
        self.inventory.append(area.inventory[index])
        area.inventory.remove(at: index)
    }
    
    func dropItem(at index: Int) {
        area.inventory.append(self.inventory[index])
        self.inventory.remove(at: index)
    }
}
