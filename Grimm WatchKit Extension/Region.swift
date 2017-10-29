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
    let routes: [Direction]
    
    init(routes: [Direction] = []) {
        self.routes = routes
    }
    
    func areasAvail(near location: WorldLocation) -> [Direction] {
        let area = areas.get(at: location.area)
        return area.areasAvail()
    }
    
    func regionsAvail() -> [Direction] {
        return Direction.invert(routes)
    }
    
    func area(of location: WorldLocation) -> Area {
        return areas.get(at: location.area)
    }
}
