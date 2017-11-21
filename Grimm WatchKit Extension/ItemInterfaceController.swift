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
    
    var player: Entity?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let inventories = context as! (playerItems: [Item],
                                       groundItems: [Item],
                                       player: Entity)
        
        load(playerItemTable, with: inventories.playerItems)
        load(groundItemTable, with: inventories.groundItems)
        self.player = inventories.player
    }
    
    private func load(_ table: WKInterfaceTable, with items: [Item]) {
        table.setNumberOfRows(items.count, withRowType: "Item")
        
        for index in 0..<items.count {
            let row = table.rowController(at: index) as! ItemRow
            row.itemLabel.setText(items[index].name)
            row.item = items[index]
        }
    }
    
    private func insert(_ item: Item, into table: WKInterfaceTable) {
        table.insertRows(at: [table.numberOfRows], withRowType: "Item")
        let row = table.rowController(at: table.numberOfRows - 1) as! ItemRow
        row.itemLabel.setText(item.name)
        row.item = item
    }
    
    private func swapItems(from giver: WKInterfaceTable, at index: Int,
                           to taker: WKInterfaceTable) {
        let row = giver.rowController(at: index) as! ItemRow
        insert(row.item!, into: taker)
        giver.removeRows(at: [index])
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        // Updates entity's + area's inventory AND tables
        switch table {
        case _ where table === playerItemTable:
            player!.dropItem(at: rowIndex)
            swapItems(from: playerItemTable, at: rowIndex, to: groundItemTable)
        case _ where table === groundItemTable:
            player!.pickupItem(at: rowIndex)
            swapItems(from: groundItemTable, at: rowIndex, to: playerItemTable)
        default:
            // Ignore
            break
        }
    }
}
