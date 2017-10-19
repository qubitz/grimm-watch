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

    @IBOutlet var itemTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        var items = context as! [String]
        
        itemTable.setNumberOfRows(items.count, withRowType: "Item")
        
        for index in 0..<items.count {
            let row = itemTable.rowController(at: index) as! Item
            row.itemLabel.setText(items[index])
        }
    }
}
