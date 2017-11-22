//
//  Direction.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

enum Direction: String, Codable {
    case north, south, east, west, up, down
    
    static let all = [Direction.north, .east, .south, .west, .up, .down]
    
    var unitVec: Vec3 {
        switch self {
        case .north:
            return Vec3.forward
        case .south:
            return Vec3.backward
        case .east:
            return Vec3.right
        case .west:
            return Vec3.left
        case .up:
            return Vec3.up
        case .down:
            return Vec3.down
        }
    }
    
    static func invert(_ directions: [Direction]) -> [Direction] {
        var inverted = all
        
        for dir in directions {
            if let index = inverted.index(of: dir) {
                inverted.remove(at: index)
            }
        }
        return inverted  // basically all - 'directions'
    }
}
