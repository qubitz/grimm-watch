//
//  Grid3D.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/22/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

class Grid3D<T: Codable>: Codable {
    var grid = [[[T]]]()

    func set(at point: Point, to value: T) {
        grid[point.x][point.y][point.z] = value
    }
    
    func get(at point: Point) -> T {
        return grid[point.x][point.y][point.z]
    }
}
