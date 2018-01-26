//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Context holding the region and area positions of an object.
///
/// Used to bundle and transfer information of an object's location.
/// For example, an `Entity`'s location within a `Map` is held by
/// a `WorldLocation`.
struct WorldLocation: Codable {
    /// Three-dimensional area index of an area within a region.
    var areaIndex: Vec3
    /// Three-dimensional region index of a region within a map.
    var regionIndex: Vec3
    
    /// Constructs a `WorldLocation` instance with the given
    /// region and area as `Vec3`s.
    ///
    /// - Parameters:
    ///   - region: Region to hold. Defaults to (0,0,0).
    ///   - area: Area to hold. Defaults to (0,0,0).
    init(regionIndex: Vec3 = Vec3(0,0,0), areaIndex: Vec3 = Vec3(0,0,0)) {
        self.regionIndex = regionIndex
        self.areaIndex = areaIndex
    }
    
    /// Constructs a `WorldLocation` instance with the given
    /// region and area as `Point`s.
    ///
    /// - Parameters:
    ///   - region: Region to hold. Defaults to (0,0,0).
    ///   - area: Area to hold. Defaults to (0,0,0).
    init(regionIndex: Point = (0, 0, 0), areaIndex: Point = (0, 0, 0)) {
        self.init(regionIndex: Vec3(regionIndex), areaIndex: Vec3(areaIndex))
    }
}

/// Returns true if two `WorldLocation`s are holding the same area and region.
///
/// - Parameters:
///   - lhs: `Vec3` to be equated.
///   - rhs: `Vec3` to be equated.
/// - Returns: True if area and region of both are equal; false otherwise.
func ==(lhs: WorldLocation, rhs: WorldLocation) -> Bool {
    return lhs.areaIndex == rhs.areaIndex &&
           lhs.regionIndex == rhs.regionIndex
}

/// Reterns true if two `WorldLocation`s are not holding the same area and region.
///
/// - Parameters:
///   - lhs: `Vec3` to be equated.
///   - rhs: `Vec3` to be equated.
/// - Returns: True if area or region of both are not equal; false otherwise.
func !=(lhs: WorldLocation, rhs: WorldLocation) -> Bool {
    return !(lhs == rhs)
}
