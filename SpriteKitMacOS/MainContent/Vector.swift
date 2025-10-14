//
//  Vector.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 29.09.2025.
//
import Foundation

struct Vector {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(x: Int32, y: Int32) {
        self.x = Int(x)
        self.y = Int(y)
    }
    
    static var zero: Vector {
        Vector(x: 0, y: 0)
    }
    
    static var left: Vector {
        Vector(x: -1, y: 0)
    }
    
    static var right: Vector {
        Vector(x: 1, y: 0)
    }
    
    static var up: Vector {
        Vector(x: 0, y: 1)
    }
    
    static var down: Vector {
        Vector(x: 0, y: -1)
    }
    
    static func + (lhs: Vector, rhs: Vector) -> Vector {
        Vector(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func - (lhs: Vector, rhs: Vector) -> Vector {
        Vector(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func distance(_ v1: Vector, _ v2: Vector) -> Double {
        let dist = v1 - v2
        return sqrt(Double(dist.x * dist.x + dist.y * dist.y))
    }
}

extension Vector: Hashable { }
