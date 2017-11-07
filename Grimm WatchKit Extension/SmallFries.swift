//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/23/17.
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

func +(rhs: Vec3, lhs: Vec3) -> Vec3 {
    return Vec3(rhs.x + lhs.x, rhs.y + lhs.y, rhs.z + lhs.z)
}

func +(rhs: Vec3, lhs: Point) -> Vec3 {
    return rhs + Vec3(lhs.x, lhs.y, lhs.z)
}

func +=(rhs: inout Vec3, lhs: Point) {
    rhs = rhs + Vec3(lhs.x, lhs.y, lhs.z)
}

struct WorldLocation: Codable {
    var area: Vec3
    var region: Vec3
    
    init(inRegion region: Point = (0, 0, 0), inArea area: Point = (0, 0, 0)) {
        self.area = Vec3(area.x, area.y, area.z)
        self.region = Vec3(region.x, region.y, region.z)
    }
    
    init(inRegion region: Vec3 = Vec3(0,0,0), inArea area: Vec3 = Vec3(0,0,0)) {
        self.region = region
        self.area = area
    }
}

enum Direction: String, Codable {
    case north, south, east, west, up, down
    
    static let all = [Direction.north, .east, .south, .west, .up, .down]
    
    var raw: Vec3 {
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

class Item: Codable {
    var name: String
    var health: Int
    
    init(_ name: String, health: Int = 100) {
        self.name = name
        self.health = health
    }
    
    func repair(by amount: Int) {
        health += amount
    }
    
    func hurt(by amount: Int = 10) {
        health -= amount
    }
}
