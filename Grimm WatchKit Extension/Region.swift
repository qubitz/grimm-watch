//
//  Region.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Region: Codable {
    let areas = Grid3D<Area>()
    let walls: [Direction]
    
    init(walls: [Direction] = []) {
        self.walls = walls
    }
    
    func areasAvail(near location: WorldLocation) -> [Direction] {
        let area = areas.get(at: location.area)
        return area.areasAvail()
    }
    
    func regionsAvail() -> [Direction] {
        return Direction.invert(walls)
    }
    
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.area)
    }
}
