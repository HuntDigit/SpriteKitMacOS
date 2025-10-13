//
//  Heading.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 13.10.2025.
//

import Foundation

enum Heading: Int, CaseIterable {
    case North, NorthEast, East, SouthEast, South, SouthWest, West, NorthWest
    
    var toVector: Vector {
        switch self {
        case .North:
            return .init(x: 0, y: 1)
        case .NorthEast:
            return .init(x: 1, y: 1)
        case .East:
            return .init(x: 1, y: 0)
        case .SouthEast:
            return .init(x: 1, y: -1)
        case .South:
            return .init(x: 0, y: -1)
        case .SouthWest:
            return .init(x: -1, y: -1)
        case .West:
            return .init(x: -1, y: 0)
        case .NorthWest:
            return .init(x: -1, y: 1)
        }
    }
    
    static func vectorToHeading(_ vector: Vector) -> Heading? {
        allCases.first(where: { $0.toVector == vector })
    }
}
