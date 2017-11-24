//
//  Movement.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct Movement: Action {
    var name: String!
    var completedName: String!
    
    var direction: Direction?
    var destination: WorldLocation?
    
    init(in direction: Direction!) {
        self.direction = direction
        self.destination = nil
        
        name = "Move " + direction.rawValue
        completedName = "Moved " + direction.rawValue
    }
    
    init(to destination: WorldLocation!) {
        self.destination = destination
        self.direction = nil
        
        name = "Move to " + destination.area.description
        completedName = "Moved to " + destination.area.description
    }
}
