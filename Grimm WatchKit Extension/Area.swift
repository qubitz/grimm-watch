//
//  Area.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Area: Codable, CustomStringConvertible {
    var description: String
    var location: WorldLocation
    var region: Region
    var inventory = [Item]()
    var routes: [Direction]  // TODO: make routes private and walls computed value
    var entites = [Entity]()
    
    init(at location: WorldLocation, withItems items: [Item], andDesc desc: String, routes: [Direction] = Direction.all, parent: Region) {
        self.location = location
        self.description = desc
        self.inventory = items
        self.routes = routes
        self.region = parent
    }
    
    func areasAvail() -> [Direction] {
        return Direction.invert(routes)
    }
    
    func addEntity(with items: [Item]) -> Entity {
        entites.append(Entity(at: self.location, with: items, parent: self))
        return entites.last!
    }
}
