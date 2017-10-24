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
    
    init() {
        let sampleArea = Area(withItems: ["Hammer",
                                          "Rusty nail",
                                          "Lost key"],
                              andDesc:
"""
Ah, home sweet home. The smell of pine wood and a great view of your back
yard tells you you're in your treehouse.
""")
        areas.setData(at: (0, 0, 0), to: sampleArea)
    }
}
