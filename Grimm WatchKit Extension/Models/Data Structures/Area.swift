//
//  Area.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Holds and manages the details of an area.
///
/// Area is Grimm's lowest-level data structure for
/// holding all of its level information. Areas hold
/// nearly everything from entites to possible routes
/// an entity can move.
class Area: Codable, CustomStringConvertible {
    /// Parent region that contains this area.
    var region: Region
    
    /// Location of the area.
    var location: WorldLocation
    
    /// Text description of the area.
    var description = "Undescribable"
    
    /// List of items held in the area.
    var inventory = [Item]()
    
    /// List of entities within the area.
    var entites = [Entity]()
    
    /// Possible ways to move.
    var moves = Movement.all
    
    /// Impossible directions to go.
    var walls: [Direction] {
        var dirs = [Direction]()
        for route in moves {
            if let dir = route.direction {
                dirs.append(dir)
            }
        }
        return Direction.invert(dirs)
    }
    
    /// Contructs an `Area` instance
    ///
    /// - Parameters:
    ///   - location: Location of the area within a Map
    ///   - parent: Parent region which contains this area
    init(at location: WorldLocation, parent: Region) {
        self.location = location
        self.region = parent
    }
    
    /// Sets the inventory held by the area.
    ///
    /// - Note: Meant to be used in method chaining
    /// - Parameter items: Items to set (inventory)
    /// - Returns: self (current instance)
    @discardableResult
    func with(items: [Item]) -> Area {
        self.inventory = items
        return self
    }
    
    /// Sets the description of the area.
    ///
    /// - Note: Meant to be used in method chaining
    /// - Parameter desc: Description of the area
    /// - Returns: self (current instance)
    @discardableResult
    func with(desc: String) -> Area {
        self.description = desc
        return self
    }
    
    
    /// Sets the moves capable within the area.
    ///
    /// - Note: Meant to be used in method chaining
    /// - Parameter moves: List of possible moves
    /// - Returns: self (current instance)
    @discardableResult
    func with(moves: [Movement]) -> Area {
        self.moves = moves
        return self
    }
    
    /// Appends an blank entity to the area.
    ///
    /// - Returns: The entity added
    @discardableResult
    func addEntity() -> Entity {
        entites.append(Entity(at: self.location, parent: self))
        return entites.last!
    }
    
    /// Appends a given entity to the area.
    ///
    /// - Parameter entity: Entity to add
    /// - Returns: Entity added
    @discardableResult
    func add(_ entity: Entity) -> Entity {
        entites.append(entity)
        entity.area = self
        entity.location = self.location
        return entites.last!
    }
    
    /// Moves an entity wihin the area to a another area.
    ///
    /// - Parameters:
    ///   - entity: Entity to move
    ///   - destination: Location of the area
    func move(_ entity: Entity, to destination: WorldLocation) {
        if destination != location {
            if let index = entites.index(where: { $0 === entity }) {
                entites.remove(at: index)
            }
            
            MapHandler.shared.map.area(of: destination).add(entity)
        }
    }
}
