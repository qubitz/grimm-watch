//
//  Vec3.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// A tuple meant to provide cleaner looking calls
/// in functions that would otherwise take in a Vec3.
typealias Point = (x: Int, y: Int, z: Int)

/// A struct type to represent a vector of three components.
///
/// This class was designed for use in Grid3D, but I have found
/// many other uses for it. Currently, it lacks most basic vector math
/// operations.
struct Vec3: Codable, CustomStringConvertible {
    /// X component.
    var x: Int
    /// Y component.
    var y: Int
    /// Z component.
    var z: Int
    
    /// Left-facing unit vector.
    static let left = Vec3(1, 0, 0)
    /// Right-facing unit vector.
    static let right = Vec3(-1, 0, 0)
    /// Forward-facing unity vector.
    static let forward = Vec3(0, 1, 0)
    /// Backward-facing unit vector.
    static let backward = Vec3(0, -1, 0)
    /// Up-facing unit vector.
    static let up = Vec3(0, 0, 1)
    /// Down-facing unit vector.
    static let down = Vec3(0, 0, -1)
    
    /// String representation of a Vec3's components
    /// in the form: "(x, y, z)".
    ///
    ///     let example = Vec3(1, 2, 3)
    ///     print(example)
    ///     // Prints "(1, 2, 3)"
    var description: String {
        return "(\(x), \(y), \(z))"
    }
    
    /// Contructs a `Vec3` instance with
    /// x, y, and z components.
    ///
    /// - Parameters:
    ///   - x: X component.
    ///   - y: Y component.
    ///   - z: Z component.
    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    /// Contructs a `Vec3` instance from a `Point`.
    ///
    ///     let exPoint = (1, 2, 3)
    ///     let exVec3 = Vec3(exPoint)
    ///     print(exVec3)
    ///     // Prints "(1, 2, 3)"
    ///
    /// - Parameter point: A point from which to create the `Vec3` instance.
    init(_ point: Point) {
        self.init(point.x, point.y, point.z)
    }
    
    /// Returns the `Vec3` as a new `Point`.
    ///
    /// - Returns: A point with the same x, y, and z components.
    func asPoint() -> Point {
        return (x, y, z)
    }
}

/// Adds two `Vec3`'s componenets together.
///
///     let vecOne = Vec3(1, 2, 3)
///     let vecTwo = Vec3(4, 5, 6)
///     let result = vecOne + vec
///     print(result)
///     // Prints "(5, 7, 9)"
///
/// - Parameters:
///   - lhs: `Vec3` to add.
///   - rhs: `Vec3` to add.
/// - Returns: The created `Vec3` with the given
///            components added together respectively.
func +(lhs: Vec3, rhs: Vec3) -> Vec3 {
    return Vec3(rhs.x + lhs.x, rhs.y + lhs.y, rhs.z + lhs.z)
}

/// Adds a `Vec3` and `Point` components together.
///
///     let vec = Vec3(1, 2, 3)
///     let point = (4, 5, 6)
///     let result: Vec3 = vec + point
///     print(result)
///     // Prints "(5, 7, 9)"
///
/// - Parameters:
///   - lhs: `Vec3` to add.
///   - rhs: `Point` to add.
/// - Returns: The created `Vec3` with the given
///            components added together respectively.
func +(lhs: Vec3, rhs: Point) -> Vec3 {
    return lhs + Vec3(rhs.x, rhs.y, rhs.z)
}

/// Adds the right hand side to the given inout `Vec3`.
///
///     let vecOne = Vec3(1, 2, 3)
///     let vecTwo = Vec3(4, 5, 6)
///     vecTwo += vecOne
///     print(vecTwo)
///     // Prints "(5, 7, 9)"
///
/// - Parameters:
///   - lhs: `Vec3` to be modiified.
///   - rhs: `Vec3` to be added.
func +=(lhs: inout Vec3, rhs: Vec3) {
    lhs = lhs + rhs
}

/// Adds right hand side to the given inout `Vec3`.
///
///     let vec = Vec3(1, 2, 3)
///     vec += (4, 5, 6)
///     print(vec)
///     // Prints "(5, 7, 9)"
///
/// - Parameters:
///   - lhs: `Vec3` to be modified.
///   - rhs: `Point` to be added.
func +=(lhs: inout Vec3, rhs: Point) {
    lhs = lhs + Vec3(rhs.x, rhs.y, rhs.z)
}

/// Returns true if both `Vec3`s have the same xyz components.
///
///     let vecOne = Vec3(1, 2, 3)
///     let vecTwo = Vec3(1, 2, 3)
///     if vecOne == vecTwo {
///         print(vecOne)
///     }
///     // Prints "(1, 2, 3)"
///
/// - Parameters:
///   - lhs: `Vec3` to be equated.
///   - rhs: `Vec3` to be equated.
/// - Returns: True if `lhs` is equal to `rhs`; false otherwise.
func ==(lhs: Vec3, rhs: Vec3) -> Bool {
    return lhs.x == rhs.x
        && lhs.y == rhs.y
        && lhs.z == rhs.z
}

/// Returns true if both `Vec3`s don't have the same xyz components.
///
///     let vecOne = Vec3(1, 2, 3)
///     let vecTwo = Vec3(2, 2, 3)
///     if vecOne != vecTwo {
///         print(vecOne)
///     }
///     // Prints "(1, 2, 3)"
///
/// - Parameters:
///   - lhs: `Vec3` to be equated.
///   - rhs: `Vec3` to be equated.
/// - Returns: True if `lhs` is not equal to `rhs`; false otherwise.
func !=(lhs: Vec3, rhs: Vec3) -> Bool {
    return !(lhs == rhs)
}
