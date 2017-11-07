//
//  MapHandler.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/27/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class MapHandler {
    static let shared = MapHandler()
    
    var map: Map
    var player: Entity
    
    init() {
        (map, player) = MapBuilder.buildNew()
    }
}
