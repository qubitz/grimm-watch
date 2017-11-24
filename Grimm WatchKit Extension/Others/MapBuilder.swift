//
//  MapBuilder.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/27/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct MapBuilder {
    static func buildNew() -> (Map, Entity) {
        let map = Map()
        let mainRegion = map.makeRegion(nil)
        
        mainRegion.makeArea(nil)
            .with(items: [Item("Small dagger")])
            .with(desc: "Nailed boards makeup a treehouse")
            .with(routes: [.down])
        
        let aedan = mainRegion.workingArea.addEntity()
            .with(items: [Item("Pocket lint")])
        
        mainRegion.makeArea(.down)
            .with(items: [Item("Key"),
                          Item("Garden shovel"),
                          Item("Flower pedals")])
            .with(desc: "A tree has nailed boards with a garden near")
            .with(routes: [.up, .west])
        
        mainRegion.makeArea(.west)
            .with(desc: "A long trail spawls ahead between home and the village")
            .with(routes: [.up, .west])
        
        let mainStreet = mainRegion.makeArea(.west)
            .with(items: [Item("A few pebbles")])
            .with(desc: "Traders and merchant shops line main street")
            .with(routes: [.east, .north, .south])
        
        mainRegion.makeArea(.south)
            .with(desc: "Amoung the many shops lies \"Uncle Nans\" shop")
            .with(routes: [.north, .east])
        
        mainRegion.makeArea(.east)
            .with(desc: "Inside Nans shop, groceries lay ordered by category")
            .with(routes: [.west])
        
        mainRegion.cursor = mainStreet.location.area
        
        mainRegion.makeArea(.north)
            .with(desc: "The street's shop density lowers  before heading through the forest")
            .with(routes: [.south])
        
        return (map, aedan)
    }
}

// SO MUCH CLEANER!!!! :D
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
