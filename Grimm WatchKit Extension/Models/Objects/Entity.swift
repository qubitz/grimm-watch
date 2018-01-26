//
//  Entity.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/24/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// An object that represents a moveable entity
/// within Grimm capable of manageing items and
/// and acting on effects.
///
/// This object was built mainly for the `player`
/// property in `PlayerController`, but multiple
/// entities interacting with each other is
/// possible with some work.
class Entity: Codable {
    /// List of items held an entity.
    var inventory = [Item]()
    
    /// Location in which the entity resides.
    var location: WorldLocation
    
    /// Area that contains the entity.
    var area: Area
    
    /// Contructs an `Entity` instance.
    ///
    /// - Parameters:
    ///   - location: Location at which to spawn.
    ///   - parent: Area that contains the entity.
    init(at location: WorldLocation, parent: Area) {
        self.location = location
        self.area = parent
    }
    
    /// Sets the inventory held by the entity.
    ///
    /// - Note: Meant to be used in method chaining.
    /// - Parameter items: Items to be set (aka inventory).
    /// - Returns: `self` (current instance).
    @discardableResult
    func with(items: [Item]) -> Entity {
        self.inventory = items
        return self
    }
    
    /// Moves the entity in a direction.
    ///
    /// - Important: Does not check if
    /// - Parameter direction: Direction to move
    func move(in direction: Direction) {
        var destination = self.location
        destination.areaIndex += direction.unitVec
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
