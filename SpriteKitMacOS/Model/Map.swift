//
//  Map.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation

struct Map {
    
    static let mapString = [
        """
          #################
          #...............#
          #.......T.......#
          #...............#
          #...............#
          #######...#######
                #...#
                #...#
        #########...#########
        #...E...............#
        #...............E...#
        #########...#########
                #...#
                #...#
          #######...#######
          #C..............#
          #...............#
          #.......@.......#
          #...............#
          #################
        """
    ]
    
    var cells: [Vector: Cell] = [:]
    
    var playerStartPosition: Vector = .zero
    var targetPosition: Vector = .zero
    var cameraPosition: Vector = .zero
    var enemySpawnPositions: [Vector] = []
    
    init(mapString: String) {
        let lines = mapString
            .split(separator: "\n")
            .reversed()
        
        var x = 0
        var y = 0
        
        for line in lines {
            for ch in line {
                let coordinate = Vector(x: x, y: y)
                
                if ch == "@" {
                    playerStartPosition = coordinate
                    cells[coordinate] = .floor
                } else if ch == "T" {
                    targetPosition = coordinate
                    cells[coordinate] = .floor
                } else if ch == "C" {
                    cameraPosition = coordinate
                    cells[coordinate] = .floor
                } else if ch == "E" {
                    enemySpawnPositions.append(coordinate)
                    cells[coordinate] = .floor
                } else {
                    cells[coordinate] = Cell(rawValue: ch) ?? .void
                }
                x += 1
            }
            x = 0
            y += 1
        }
    }
    
    @inlinable
    func getCell(_ coordinate: Vector) -> Cell {
        cells[coordinate, default: .void]
    }
}

enum Cell: Character {
    case floor = "."
    case wall  = "#"
    case void  = " "
    
    var name: String {
        switch self {
            case .floor: return "Floor"
            case .wall:  return "Wall"
            case .void:  return "Void"
        }
    }
    
    var enterable: Bool {
        switch self {
        case .floor:
            return true
        default:
            return false
        }
    }
}
