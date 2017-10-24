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
    
    func setValue(x: Int, y: Int, z: Int, to value: T) {
        grid[x][y][z] = value
    }
    
    func setData(at point: (x: Int, y: Int, z: Int), to value: T) {
        setValue(x: point.x, y: point.y, z: point.z, to: value)
    }
}
