//
//  Vec3.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

// Vec3 and point are meant to be interchangeable (though its ugly...)
typealias Point = (x: Int, y: Int, z: Int)

struct Vec3: Codable, CustomStringConvertible {
    var x: Int
    var y: Int
    var z: Int
    
    static let left = Vec3(1, 0, 0)
    static let right = Vec3(-1, 0, 0)
    static let forward = Vec3(0, 1, 0)
    static let backward = Vec3(0, -1, 0)
    static let up = Vec3(0, 0, 1)
    static let down = Vec3(0, 0, -1)
    
    var description: String {
        return "(\(x), \(y), \(z))"
    }
    
    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ point: Point) {
        self.x = point.x
        self.y = point.y
        self.z = point.z
    }
    
    func asPoint() -> Point {
        return (x, y, z)
    }
}

func +(lhs: Vec3, rhs: Vec3) -> Vec3 {
    return Vec3(rhs.x + lhs.x, rhs.y + lhs.y, rhs.z + lhs.z)
}

func +(lhs: Vec3, rhs: Point) -> Vec3 {
    return lhs + Vec3(rhs.x, rhs.y, rhs.z)
}

func +=(lhs: inout Vec3, rhs: Vec3) {
    lhs = lhs + rhs
}

func +=(lhs: inout Vec3, rhs: Point) {
    lhs = lhs + Vec3(rhs.x, rhs.y, rhs.z)
}

func ==(lhs: Vec3, rhs: Vec3) -> Bool {
    return lhs.x == rhs.x &&
        lhs.y == rhs.y &&
        lhs.z == rhs.z
}

func !=(lhs: Vec3, rhs: Vec3) -> Bool {
    return !(lhs == rhs)
}
