//
//  Region.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Region: Codable {
    private let areas = Grid3D<Area>(withSize: Vec3(100, 100, 100))
    
    /// The parent map that contains this region.
    var map: Map
    
    /// The current point from which to create areas.
    var cursor = Vec3(50, 50, 50)
    
    /// Location of the region.
    var location: Vec3
    
    /// Possible directions to move.
    var routes = Direction.all
    
    /// Impossible directions to move.
    var walls: [Direction] {
        return Direction.invert(routes)
    }
    
    /// The area at the cursor.
    var workingArea: Area {
        return areas.get(at: cursor)
    }
    
    /// Manages a three-dimenional plane of areas
    ///
    /// Grimm's second-level data structure which holds all
    /// areas within a subsection of areas called a region.
    /// Regions are broken up into areas which hold the details
    /// of a Grimm level
    ///
    /// - Parameters:
    ///   - location: Location of the region within a Map
    ///   - parent: Parent map which contains this region
    init(at location: Vec3, parent: Map) {
        self.location = location
        self.map = parent
    }
    
    /// Sets the routes of the region.
    ///
    /// - Note: Meant to be used in method chaining
    /// - Parameter routes: Possible directions to move
    /// - Returns: self (current instance)
    @discardableResult
    func with(routes: [Direction]) -> Region {
        self.routes = routes
        return self
    }
    
    /// Sets the starting cursor (origin) of the region
    ///
    /// - Note: Meant to be used in method chaining
    /// - Parameter origin: Starting point of the cursor
    /// - Returns: self (current instance)
    @discardableResult
    func with(origin: Point) -> Region {
        self.cursor = Vec3(origin)
        return self
    }
    
    /// Gets the area at the given location
    ///
    /// - Parameter location: Location of the area
    /// - Returns: The area at that location
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.area)
    }
    
    
    /// Creates an area from the cursor in the given direction.
    ///
    /// - Note: If the direction is nil an area will be created at the cursor
    /// - Parameter spawnDirection: Direction in which to create the area
    /// - Returns: The new area created
    @discardableResult
    func makeArea(_ spawnDirection: Direction?) -> Area {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        areas.set(at: cursor, to: Area(at: WorldLocation(inRegion: location,
                                                         inArea: cursor), 
                                       parent: self))
        return areas.get(at: cursor)
    }
}
