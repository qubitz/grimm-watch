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
        
        let map = Map(withOrigin: (5, 5, 5))
        let mainRegion = map.makeRegion(nil, withOrigin: (50, 51, 50))
        
        mainRegion.makeArea(nil, withItems: [Item("Small dagger")],
                            andDesc: "Ah...home sweet treehouse",
                            routes: [.down])
        let aedan = mainRegion.workingArea.addEntity(with: [Item("Pocket lint")])
        mainRegion.makeArea(.down, withItems: [Item("Key")],
                            andDesc: "A tree has a ladder nailed into it",
                            routes: [.up])
        
        return (map, aedan)
    }
}
