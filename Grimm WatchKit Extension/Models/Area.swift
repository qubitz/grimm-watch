//
//  Area.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Area: Codable, CustomStringConvertible {
    
    var location: WorldLocation
    var region: Region
    var description = "Undescribable"
    var inventory = [Item]()
    var routes = Direction.all
    var entites = [Entity]()
    
    var walls: [Direction] {
        return Direction.invert(routes)
    }
    
    init(at location: WorldLocation, parent: Region) {
        self.location = location
        self.region = parent
    }
    
    @discardableResult
    func with(items: [Item]) -> Area {
        self.inventory = items
        return self
    }
    
    @discardableResult
    func with(desc: String) -> Area {
        self.description = desc
        return self
    }
    
    @discardableResult
    func with(routes: [Direction]) -> Area {
        self.routes = routes
        return self
    }
    
    @discardableResult
    func addEntity() -> Entity {
        entites.append(Entity(at: self.location, parent: self))
        return entites.last!
    }
    
    @discardableResult
    func add(_ entity: Entity) -> Entity {
        entites.append(entity)
        entity.area = self
        entity.location = self.location
        return entites.last!
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
