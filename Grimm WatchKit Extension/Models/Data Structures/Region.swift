//
//  Region.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Manages a three-dimenional plane of areas.
///
/// Grimm's second-level data structure which holds all
/// areas within a subsection of areas called a region.
/// Regions are broken up into areas which hold the details
/// of a Grimm level.
///
/// Note: `Region` contains a `cursor` that indexes an area within
/// the grid of areas. This cursor is used as a point of reference
/// and something from which to create new areas. In other words,
/// the `cursor` can be used to contruct a path of areas by moving
/// the `cursor` and spawning surrounding areas as it moves.
class Region: Codable {
    
    /// 3D grid of all areas within the region.
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
    
    /// Contructs a `Region` instance.
    ///
    /// - Parameters:
    ///   - location: Location of the region within a Map.
    ///   - parent: Parent map which contains this region.
    init(at location: Vec3, parent: Map) {
        self.location = location
        self.map = parent
    }
    
    /// Sets the routes of the region.
    ///
    /// - Note: Meant to be used in method chaining.
    /// - Parameter routes: Possible directions to move.
    /// - Returns: `self` (current instance).
    @discardableResult
    func with(routes: [Direction]) -> Region {
        self.routes = routes
        return self
    }
    
    /// Sets the starting cursor (origin) of the region.
    ///
    /// - Note: Meant to be used in method chaining.
    /// - Parameter origin: Starting point of the cursor.
    /// - Returns: `self` (current instance).
    @discardableResult
    func with(origin: Point) -> Region {
        self.cursor = Vec3(origin)
        return self
    }
    
    /// Gets the area at the given location.
    ///
    /// - Parameter location: Location of the area.
    /// - Returns: The area at that location.
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.areaIndex)
    }
    
    /// Returns a newly created area in the given direction from the cursor.
    ///
    /// - Note: If the direction is `nil` an area will be created at the cursor.
    /// - Parameters:
    ///   - spawnDirection: Direction in which to create the area.
    ///   - follow: Whether to point `cursor` to newly created area. Defaults
    ///             to `true`.
    /// - Returns: Th new area created.
    @discardableResult
    func makeArea(_ spawnDirection: Direction?, follow: Bool = true) -> Area {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        areas.set(at: cursor, to: Area(at: WorldLocation(regionIndex: location,
                                                         areaIndex: cursor),
                                       parent: self))
        return areas.get(at: cursor)
    }
}
