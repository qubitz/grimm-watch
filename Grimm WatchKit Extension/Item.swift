//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Item: Codable {
    var name: String!
    
    init(_ name: String) {
        self.name = name
    }
}
