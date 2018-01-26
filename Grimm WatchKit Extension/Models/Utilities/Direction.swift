//
//  Direction.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// A direction enumeration value to represent possible directions.
///
/// - Note: Diagonalization is not supported.
enum Direction: String, Codable, CustomStringConvertible {
    case north
    case south
    case east
    case west
    case up
    case down

    /// A list of all possible directions.
    static let all = [Direction.north, .east, .south, .west, .up, .down]

    /// Description for console printing.
    var description: String {
        return self.rawValue
    }
    
    /// A `Vec3` representing the unit vector.
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
    
    /// Returns a new opposite direction.
    ///
    ///     let up = Direction.up
    ///     print(up.inverted)
    ///     // Prints "down"
    ///
    /// - Returns: The opposite direction.
    var inverted: Direction {
        switch self {
        case .north:
            return .south
        case .south:
            return .north
        case .east:
            return .west
        case .west:
            return .east
        case .up:
            return .down
        case .down:
            return .up
        }
    }
    
    /// Returns a new list containing the opposite directions of the elements
    ///
    ///     var directions = [Direction.up, .west]
    ///     invert(directions) // Returns [.down, .east]
    ///
    /// - Parameter directions: List of directions to invert.
    /// - Returns: The inverted directions in the orginally given order.
    static func invert(_ directions: [Direction]) -> [Direction] {
        var inverted = [Direction]()
        
        for dir in directions {
            inverted.append(dir.inverted)
        }
        return inverted
    }
}

/// Returns a new list created from the left's elements subtracted by the
/// matching elements of the right's.
///
///     var left = Direction.all
///     var right = [Direction.south, .west]
///     var diff = left - right
///     print(diff)
///     // Prints [north, east, up, down]
///
/// - Parameter:
///   - lhs: Left hand side of the operation.
///   - rhs: Right hand side of the operation.
/// - Returns: The differene between the left and right.
func -(lhs: [Direction], rhs: [Direction]) -> [Direction] {
    let diffSet = Set(lhs).subtracting(Set(rhs))
    return Array(diffSet)
}
