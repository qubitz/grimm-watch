//
//  ItemInterfaceController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/11/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit
import Foundation

/// Responsible for controlling UI item tables as well as player and area's
/// inventories.
class ItemInterfaceController: WKInterfaceController {

    // UI Tables
    @IBOutlet var playerItemTable: WKInterfaceTable!
    @IBOutlet var groundItemTable: WKInterfaceTable!
    
    /// The player entity of Grimm.
    var player: Entity?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let (playerItems, groundItems, player) = context as! ([Item], [Item], Entity)
        
        load(playerItemTable, with: playerItems)
        load(groundItemTable, with: groundItems)
        self.player = player
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        // Updates entity's + area's inventory AND tables
        switch table {
        case _ where table === playerItemTable:
            player!.dropItem(at: rowIndex)
            swapItems(from: playerItemTable, to: groundItemTable, at: rowIndex)
        case _ where table === groundItemTable:
            player!.pickupItem(at: rowIndex)
            swapItems(from: groundItemTable, to: playerItemTable, at: rowIndex)
        default:
            // Only two tables exsist
            break
        }
    }
    
    /// Loads the item data into the UI item table.
    ///
    /// - Parameters:
    ///   - table: Table to load item data into.
    ///   - items: Items to load into the table.
    private func load(_ table: WKInterfaceTable, with items: [Item]) {
        table.setNumberOfRows(items.count, withRowType: "Item")
        
        for index in 0..<items.count {
            let row = table.rowController(at: index) as! ItemRow
            row.itemLabel.setText(items[index].name)
            row.item = items[index]
        }
    }
    
    /// Inserts an `Item` into an item UI table.
    ///
    /// - Parameters:
    ///   - item: Item to insert.
    ///   - table: Table in which to insert given item.
    private func insert(_ item: Item, into table: WKInterfaceTable) {
        table.insertRows(at: [table.numberOfRows], withRowType: "Item")
        let row = table.rowController(at: table.numberOfRows - 1) as! ItemRow
        row.itemLabel.setText(item.name)
        row.item = item
    }
    
    /// Swap itmes between two item UI tables.
    ///
    /// - Parameters:
    ///   - giver: The table that is giving the item.
    ///   - taker: The table that is taking the item.
    ///   - index: The index of the item to swap.
    private func swapItems(from giver: WKInterfaceTable, to taker: WKInterfaceTable,
                           at index: Int) {
        let row = giver.rowController(at: index) as! ItemRow
        giver.removeRows(at: [index])
        insert(row.item!, into: taker)
    }
}
