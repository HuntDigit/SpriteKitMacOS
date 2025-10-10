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
    
    static var zero: Vector {
        Vector(x: 0, y: 0)
    }
}

extension Vector: Hashable { }
