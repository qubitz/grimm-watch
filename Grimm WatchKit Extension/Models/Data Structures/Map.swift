//
//  Map.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Map: Codable {
    private let regions = Grid3D<Region>(withSize: Vec3(10, 10, 10))
    
    /// Manages a three-dimensional space of regions
    ///
    /// Grimm's highest-level data structure which holds the
    /// the entire level a single Grimm save. A map is broken up
    /// into regions which is broken up into areas which hold the
    /// details of a Grimm level.
    init() {}
    
    /// The current point from which to create regions
    var cursor = Vec3(5, 5, 5)
    
    /// Gets the area at the given location.
    ///
    /// - Parameter location: Location of the area
    /// - Returns: The area at the given location
    func area(of location: WorldLocation) -> Area {
        return region(of: location).area(of: location)
    }
    
    /// Gets the region at the given location.
    ///
    /// - Parameter location: Location of the region
    /// - Returns: The region at the given location
    func region(of location: WorldLocation) -> Region {
        return regions.get(at: location.region)
    }
    
    /// Creates a region from the cursor in the given direction.
    ///
    /// - Note: If the direction is nil a region will be created at the cursor
    /// - Parameter spawnDirection: Direction in which to create the region
    /// - Returns: The new region created
    @discardableResult
    func makeRegion(_ spawnDirection: Direction?) -> Region {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        regions.set(at: cursor, to: Region(at: cursor, parent: self))
        return regions.get(at: cursor)
    }
}
