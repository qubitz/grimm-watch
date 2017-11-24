//
//  Region.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Region: Codable {
    let areas = Grid3D<Area>(withSize: Vec3(100, 100, 100))
    var map: Map
    var cursor = Vec3(50, 50, 50)
    var routes = Direction.all
    var location: Vec3

    var walls: [Direction] {
        return Direction.invert(routes)
    }
    
    var workingArea: Area {
        return areas.get(at: cursor)
    }
    
    init(at location: Vec3, parent: Map) {
        self.location = location
        self.map = parent
    }
    
    @discardableResult
    func with(routes: [Direction]) -> Region {
        self.routes = routes
        return self
    }
    
    @discardableResult
    func with(origin: Point) -> Region {
        self.cursor = Vec3(origin)
        return self
    }
    
    @discardableResult
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.area)
    }
    
    @discardableResult
    func makeArea(_ spawnDirection: Direction?) -> Area {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        areas.set(at: cursor, to: Area(at: WorldLocation(inRegion: location,
                                                         inArea: cursor), 
                                       parent: self))
        return areas.get(at: cursor)
    }
}
