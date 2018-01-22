//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/12/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit

/// Table row that displays an item object at the player's location.
class ItemRow: NSObject {

    /// Label belonging to the row
    @IBOutlet var itemLabel: WKInterfaceLabel!
    
    /// The item the row displays.
    ///
    /// - Note: Modifying this property will change the referenced item.
    var item: Item?
}
