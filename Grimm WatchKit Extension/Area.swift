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
    
    init(at location: WorldLocation, withItems items: [Item] = [], andDesc desc: String, routes: [Direction] = Direction.all, parent: Region) {
        self.location = location
        self.description = desc
        self.inventory = items
        self.routes = routes
        self.region = parent
    }
    
    func addEntity(with items: [Item]) -> Entity {
        entites.append(Entity(at: self.location, with: items, parent: self))
        return entites.last!
    }
    
    func add(_ entity: Entity) {
        entites.append(entity)
        entity.area = self
        entity.location = self.location
    }
    
    func move(_ entity: Entity, to destination: WorldLocation) {
        if destination != location {
            if let index = entites.index(where: { $0 === entity }) {
                entites.remove(at: index)
            }
            
            MapHandler.shared.map.area(of: destination).add(entity)
        }
    }
}
