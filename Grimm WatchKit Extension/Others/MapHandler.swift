//
//  MapHandler.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/27/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Singleton class that holds onto the current map and player
/// being used in Grimm.
class MapHandler {
    
    /// The singleton instance of `MapHandler`.
    static let shared = MapHandler()
    
    /// The currently loaded map of Grimm.
    var map: Map
    
    /// The player instance held within `map`.
    var player: Entity
    
    /// Contructs a new `MapHandler` instance by generating a new map
    /// and player.
    init() {
        (map, player) = MapBuilder.buildNew()
    }
}
