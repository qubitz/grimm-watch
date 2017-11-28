//
//  Movement.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct Movement: Action {
    static let all = [Movement(.north),
                      Movement(.east),
                      Movement(.south),
                      Movement(.west),
                      Movement(.up),
                      Movement(.down)]
    
    var name: String
    var completedName = ""

    var direction: Direction?
    var destination: WorldLocation?

    init(_ direction: Direction) {
        self.direction = direction
        self.destination = nil

        name = "Move " + direction.rawValue
        pastTenseVerb = "Moved"
    }

    init(to destination: WorldLocation) {
        self.destination = destination
        self.direction = nil

        name = "Move to " + destination.area.description
        pastTenseVerb = "Moved"
    }
    
    func encapsulate(_ directions: [Direction]) -> [Movement] {
        var moves = [Movement]()
        
        for dir in directions {
            moves.append(Movement(dir))
        }
        return moves
    }
    
    func with(name: String, pastVerb: String) -> Movement {
        var newMove = self
        newMove.name = name
        newMove.pastTenseVerb = pastVerb
        return newMove
    }
}

