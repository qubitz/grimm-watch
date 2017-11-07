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
    var cursor: Vec3
    var routes: [Direction]
    var location: Vec3
    
    var workingArea: Area {
        return areas.get(at: cursor)
    }
    
    init(at location: Vec3, routes: [Direction] = [], withOrigin origin: Point, parent: Map) {
        self.location = location
        self.routes = routes
        self.cursor = Vec3(origin)
        self.map = parent
    }
    
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.area)
    }
    
    // TODO: Reduce, reuse, recycle! Way too many params...
    func makeArea(_ spawnDirection: Direction?, withItems items: [Item] = [], andDesc desc: String, routes: [Direction] = Direction.all) -> Area {
        cursor = (spawnDirection != nil) ? cursor + spawnDirection!.unitVec : cursor
        areas.set(at: cursor, to: Area(at: WorldLocation(inRegion: location, inArea: cursor),
                                       withItems: items, andDesc: desc,
                                       routes: routes, parent: self))
        return areas.get(at: cursor)
    }
}
