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
    
    init() {
        regions.setData(at: (0, 0, 0), to: Region())
    }
}
