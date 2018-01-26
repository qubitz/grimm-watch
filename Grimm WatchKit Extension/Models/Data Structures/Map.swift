//
//  Map.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Manages a three-dimensional space of regions.
///
/// Grimm's highest-level data structure which holds the
/// the entire level a single Grimm save. A map is broken up
/// into regions which is broken up into areas which hold the
/// details of a Grimm level.
///
/// Note: `Map` contains a `cursor` that indexes a region within
/// the grid of regions. This cursor is used as a point of reference
/// and something from which to create new regions. In other words,
/// the `cursor` can be used to contruct a path of regions by moving
/// the `cursor` and spawning surrounding regions as it moves.
class Map: Codable {
    
    /// 3D grid of all regions within a `Map`.
    private let regions = Grid3D<Region>(withSize: Vec3(10, 10, 10))
    
    /// Current point from which to create regions.
    var cursor = Vec3(5, 5, 5)
    
    /// Contructs a `Map` instance.
    init() {}
    
    /// Returns the area at the given location.
    ///
    /// - Parameter location: Location of the area
    /// - Returns: Area at the given location
    func area(of location: WorldLocation) -> Area {
        return region(of: location).area(of: location)
    }
    
    /// Returns the region at the given location.
    ///
    /// - Parameter location: Location of the region
    /// - Returns: Region at the given location
    func region(of location: WorldLocation) -> Region {
        return regions.get(at: location.regionIndex)
    }
    
    /// Returns a newly created region in the given direction from the cursor.
    ///
    /// - Note: If the direction is nil a region will be created at the cursor.
    /// - Parameters:
    ///   - spawnDirection: Direction in which to create the region.
    ///   - follow: Whether to point `cursor` to newly created region. Defaults
    ///             to `true`.
    /// - Returns: The new region created.
    @discardableResult
    func makeRegion(_ spawnDirection: Direction?, follow: Bool = true) -> Region {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        regions.set(at: cursor, to: Region(at: cursor, parent: self))
        return regions.get(at: cursor)
    }
}
