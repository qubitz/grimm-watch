//
//  Item.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

 // Point must be a struct to be Codable
struct Point: Codable {
    var x: Int
    var y: Int
    var z: Int
    
    init(_ x: Int, _ y: Int, _ z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
}

//typealias Point = (x: Int, y: Int, z: Int)

struct WorldLocation: Codable {
    var area: Point
    var region: Point
    
    init(at region: Point = Point(0, 0, 0), at area: Point = Point(0, 0, 0)) {
        self.area = area
        self.region = region
    }
}

enum Direction: String, Codable {
    case north, east, south, west, up, down
    
    static let all = [Direction.north, .east, .south, .west, .up, .down]
    
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
