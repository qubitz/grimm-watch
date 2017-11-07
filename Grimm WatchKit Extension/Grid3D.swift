//
//  Grid3D.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Grid3D<T: Codable>: Codable {
    var grid = [[[T?]]]()
    
    init(withSize size: Vec3) {
        grid = Array(repeating: Array(repeating: Array(repeating: nil,
                                                       count: size.z),
                                      count: size.y),
                     count: size.z)
    }

    func set(at point: Vec3, to value: T) {
        grid[point.x][point.y][point.z] = value
    }
    
    func set(at point: (x: Int, y: Int, z: Int), to value: T) {
        set(at: Vec3(point.x, point.y, point.z), to: value)
    }
    
    func get(at point: Vec3) -> T {
        return grid[point.x][point.y][point.z]!
    }
    
    func get(at point: (x: Int, y: Int, z: Int)) -> T {
        return get(at: Vec3(point.x, point.y, point.z))
    }
}
