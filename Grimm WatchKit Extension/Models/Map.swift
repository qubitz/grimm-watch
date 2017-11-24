//
//  Map.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Map: Codable {
    let regions = Grid3D<Region>(withSize: Vec3(10, 10, 10))
    var cursor = Vec3(5, 5, 5)
    
    init() {
    }
    
    func area(of location: WorldLocation) -> Area {
        return region(of: location).area(of: location)
    }
    
    func region(of location: WorldLocation) -> Region {
        return regions.get(at: location.region)
    }
    
    @discardableResult
    func makeRegion(_ spawnDirection: Direction?) -> Region {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        regions.set(at: cursor, to: Region(at: cursor, parent: self))
        return regions.get(at: cursor)
    }
}
