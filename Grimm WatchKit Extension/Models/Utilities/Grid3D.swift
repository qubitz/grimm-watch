//
//  Grid3D.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// Represents a three-dimensional plane of a generic type.
///
/// Used in Map and Region to create a 3D map of `Area`s.
/// Elements in Grid3D are indexed by a Vec3 and can be
/// modified directly or through member functions.
class Grid3D<T: Codable>: Codable {
    var grid = [[[T?]]]()
    
    /// Contructs a `Grid3D` instance.
    ///
    /// - Parameter size: Sizes of the three dimentions
    init(withSize size: Vec3) {
        // Creates the grid using the 'repeating' contructor of `Array`
        // which creates another array using the same contructor. This
        // happens three fold.
        //
        // All said and done, we have a third dimensional array with each cell
        // containing `nil`. To create anything  Therefore, we can know if a
        // cell is empty by observing `nil`.
        grid = Array(repeating: Array(repeating: Array(repeating: nil,
                                                       count: size.z),
                                      count: size.y),
                     count: size.z)
    }
    
    /// Contructs a `Grid3D` instance.
    ///
    /// - Parameter size: Sizes of the three dimentions
    convenience init(withSize size: Point) {
        self.init(withSize: Vec3(size))
    }
    
    /// Assign and retrieves values within the grid.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     grid[5, 5, 5] = 42
    ///     print(grid[5, 5, 5])
    ///     // Prints "42"
    ///
    /// - Parameters:
    ///   - x: X coordinate of the position.
    ///   - y: Y coordinate of the position.
    ///   - z: Z coordinate of the position.
    subscript(x: Int, y: Int, z: Int) -> T {
        get{
            return get(at: (x, y, z))
        }
        set {
            set(at: (x, y, z), to: newValue)
        }
    }
    
    /// Assigns and retrieves values within the grid.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     let index = Vec3(5, 5, 5)
    ///     grid[index] = 42
    ///     print(grid[index])
    ///     // Prints "42"
    ///
    /// - Parameter point: Position in which to reference.
    subscript(at point: Vec3) -> T {
        get {
            return self[point.x, point.y, point.z]
        }
        set {
            self[point.x, point.y, point.z] = newValue
        }
    }
    
    /// Assigns the value at a point to the given value.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     let index = Vec3(5, 5, 5)
    ///     grid.set(at: index, to: 42)
    ///     print(grid.get(at: index)
    ///     // Prints "42"
    ///
    /// - Parameters:
    ///   - point: Position in which change value.
    ///   - value: Content to assign to position.
    func set(at point: Vec3, to value: T) {
        grid[point.x][point.y][point.z] = value
    }
    
    /// Assigns the value at a point to the given value.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     grid.set(at: (5, 5, 5), to: 42)
    ///     print(grid.get(at: (5, 5, 5))
    ///     // Prints "42"
    ///
    /// - Parameters:
    ///   - point: Position in which to change value.
    ///   - value: Content to assign to position.
    func set(at point: Point, to value: T) {
        set(at: Vec3(point.x, point.y, point.z), to: value)
    }
    
    /// Retrieves the value at a given position.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     let index = Vec3(5, 5, 5)
    ///     grid.set(at: index, to: 42)
    ///     print(grid.get(at: index)
    ///     // Prints "42"
    ///
    /// - Parameter point: Position in which to get value.
    /// - Returns: Content at the given position.
    func get(at point: Vec3) -> T {
        return grid[point.x][point.y][point.z]!
    }
    
    /// Retrieves the value at a given position.
    ///
    ///     var grid = Grid<int>(withSize: (10, 10, 10))
    ///     grid.set(at: (5, 5, 5), to: 42)
    ///     print(grid.get(at: (5, 5, 5))
    ///     // Prints "42"s
    ///
    /// - Parameter point: Position in which to get value.
    /// - Returns: Content at the given position.
    func get(at point: Point) -> T {
        return get(at: Vec3(point.x, point.y, point.z))
    }
}
