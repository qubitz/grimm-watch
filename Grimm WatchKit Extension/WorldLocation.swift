//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct WorldLocation: Codable {
    var area: Vec3
    var region: Vec3
    
    init(inRegion region: Point = (0, 0, 0), inArea area: Point = (0, 0, 0)) {
        self.area = Vec3(area.x, area.y, area.z)
        self.region = Vec3(region.x, region.y, region.z)
    }
    
    init(inRegion region: Vec3 = Vec3(0,0,0), inArea area: Vec3 = Vec3(0,0,0)) {
        self.region = region
        self.area = area
    }
}

func ==(lhs: WorldLocation, rhs: WorldLocation) -> Bool {
    return lhs.area == rhs.area &&
           lhs.region == rhs.region
}

func !=(lhs: WorldLocation, rhs: WorldLocation) -> Bool {
    return !(lhs == rhs)
}
