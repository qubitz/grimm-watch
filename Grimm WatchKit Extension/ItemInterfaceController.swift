//
//  ItemInterfaceController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/11/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit
import Foundation

class ItemInterfaceController: WKInterfaceController {

    @IBOutlet var playerItemTable: WKInterfaceTable!
    @IBOutlet var groundItemTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let inventories = context as! (playerItems: [Item], groundItems: [Item])
        
        load(playerItemTable, with: inventories.playerItems)
        load(groundItemTable, with: inventories.groundItems)
    }
    
    func load(_ table: WKInterfaceTable, with items: [Item]) {
        table.setNumberOfRows(items.count, withRowType: "Item")
        
        for index in 0..<items.count {
            let row = table.rowController(at: index) as! ItemRow
            row.itemLabel.setText(items[index].name)
        }
    }
}
