//
//  MapBuilder.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/27/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct MapBuilder {
    func buildNew() -> Map {
        
        let treeHouseUp = Area(withItems: [Item("Small dagger")],
                             andDesc: "Ah...home sweet treehouse",
                             routes: [.down])
        let treeHouseDown = Area(withItems: [Item("Key")],
                                 andDesc: "A tree has a ladder nail into it",
                                 routes: [.up])
        let mainRegion = Region()
        mainRegion.areas.set(at: Point(5, 5, 5), to: treeHouseUp)
        mainRegion.areas.set(at: Point(5, 5, 4), to: treeHouseDown)
        
        let map = Map()
        map.regions.set(at: Point(1, 1, 1), to: mainRegion)
        
        return map
    }
}
