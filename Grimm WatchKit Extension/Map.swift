//
//  Map.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Map: Codable {
    let regions = Grid3D<Region>()
    
    func areasAvail(near location: WorldLocation) -> [Direction]{
        return region(of: location).areasAvail(near: location)
    }
    
    func regionsAvail(of location: WorldLocation) -> [Direction] {
        return region(of: location).regionsAvail()
    }
    
    func area(of location: WorldLocation) -> Area {
        return region(of: location).area(of: location)
    }
    
    func region(of location: WorldLocation) -> Region {
        return regions.get(at: location.region)
    }
}
