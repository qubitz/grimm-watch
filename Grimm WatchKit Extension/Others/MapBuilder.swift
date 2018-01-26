//
//  MapBuilder.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/27/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Generates new maps for Grimm.
class MapBuilder {
    
    /// Returns a new, pre-set map and a reference to the player within.
    ///
    /// - Returns: A new map that is contructed with pre-made areas and
    ///            items.
    static func buildNew() -> (Map, Entity) {
        let map = Map()
        let mainRegion = map.makeRegion(nil)
        
        mainRegion.makeArea(nil)
            .with(items: [Item("Small dagger")])
            .with(desc: "Nailed boards makeup a treehouse")
            .with(moves: [Movement(.down).with(name: "Shimmy down ladder", pastVerb: "Shimmied")])
        
        // Get player reference
        let aedan = mainRegion.workingArea.addEntity()
            .with(items: [Item("Pocket lint")])
        
        mainRegion.makeArea(.down)
            .with(items: [Item("Key"),
                          Item("Garden shovel"),
                          Item("Flower pedals")])
            .with(desc: "A tree has nailed boards with a garden near")
            .with(moves: [Movement(.up).with(name: "Climb up ladder", pastVerb: "Climbed"),
                          Movement(.west).with(name: "Head to town", pastVerb: "Headed")])
        
        mainRegion.makeArea(.west)
            .with(desc: "A long trail spawls ahead between home and the village")
            .with(moves: [Movement(.east).with(name: "Walk to treehouse", pastVerb: "Walked"),
                          Movement(.west).with(name: "Walk to town", pastVerb: "Walked")])
        
        // Bookmark main street area
        let mainStreet = mainRegion.makeArea(.west)
            .with(items: [Item("A few pebbles")])
            .with(desc: "Traders and merchant shops line main street")
            .with(moves: [Movement(.north).with(name: "Visit north village", pastVerb: "Visited"),
                          Movement(.south).with(name: "Visit south village", pastVerb: "Visted"),
                          Movement(.east).with(name: "Leave town", pastVerb: "Left")])
        
        mainRegion.makeArea(.south)
            .with(desc: "Amoung the many shops lies \"Uncle Nans\" shop")
            .with(moves: [Movement(.north).with(name: "Head back north", pastVerb: "Headed"),
                          Movement(.east).with(name: "Go into Nan's shop", pastVerb: "Went")])
        
        mainRegion.makeArea(.east)
            .with(desc: "Inside Nans shop, groceries lay ordered by category")
            .with(moves: [Movement(.west).with(name: "Leave shop", pastVerb: "Left")])
        
        // Go back to main street bookmark to build north.
        mainRegion.cursor = mainStreet.location.areaIndex
        
        mainRegion.makeArea(.north)
            .with(desc: "The street's shop density lowers  before heading through the forest")
            .with(moves: [Movement(.south).with(name: "Head back south", pastVerb: "Headed")])
        
        return (map, aedan)
    }
}

// SO UGLY!!! :D
//        let map = Map(withOrigin: (5, 5, 5))
//        let mainRegion = map.makeRegion(nil, withOrigin: (50, 50, 51))
//
//        mainRegion.makeArea(nil, withItems: [Item("Small dagger")],
//                            andDesc: "Ah...home sweet treehouse",
//                            routes: [.down])
//        let aedan = mainRegion.workingArea.addEntity(with: [Item("Pocket lint")])
//
//        mainRegion.makeArea(.down, withItems: [Item("Key"),
//                                               Item("Garden shovel"),
//                                               Item("Flower pedals")],
//                            andDesc: "A tree has nailed boards leading to a treehouse with a garden near",
//                            routes: [.up, .west])
//
//        mainRegion.makeArea(.west, andDesc: "A long trail sprawls ahead between home and the village",
//                                             routes: [.east, .west])
//        let mainStreet = mainRegion.makeArea(.west, withItems: [Item("A few pebbles")],
//                            andDesc: "Traders and merchant shops line main street",
//                            routes: [.east, .north, .south])
//        mainRegion.makeArea(.south, andDesc: "Towns people pass by \"Uncle Nans\" shop",
//                            routes: [.north, .south, .east])
//        mainRegion.makeArea(.east, andDesc: "Inside Nans shop, grocies lay ordered by category",
//                            routes: [.west])
//
//        mainRegion.cursor = mainStreet.location.area
//
//        mainRegion.makeArea(.north, andDesc: "The street's shop density lowers before heading through the forest",
//                            routes: [.south])
