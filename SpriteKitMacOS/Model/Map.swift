//
//  Map.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation
import GameplayKit

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
""",
"""
  #################
  #.......E.......#
  #.......T.......#
  #......###......#
  #.......#.......#
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
  #......###......#
  #.......@.......#
  #...............#
  #################
"""]
    
    var cells: [Vector: Cell] = [:]
    
    var playerStartPosition: Vector = .zero
    var targetPosition: Vector = .zero
    var cameraPosition: Vector = .zero
    var enemySpawnPositions: [Vector] = []
    let size: Vector
    
    private var vectorNodeMap: [Vector: GKGridGraphNode] = [:]
    private var graph = GKGridGraph<GKGridGraphNode>()
    
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
        
        var longestLine = 0
        for line in lines {
            longestLine = max(longestLine, line.count)
        }
        size = Vector(x: longestLine, y: lines.count)
        
        let result = createPathfindingGraph()
        graph = result.graph
        vectorNodeMap = result.map
    }

    @inlinable
    func getCell(_ coordinate: Vector) -> Cell {
        cells[coordinate, default: .void]
    }
    
    // MARK: Pathfinding
    
    private func createPathfindingGraph() -> (map: [Vector: GKGridGraphNode], graph: GKGridGraph<GKGridGraphNode>) {
        var nodeMap = [Vector: GKGridGraphNode]()
        let graph = GKGridGraph(fromGridStartingAt: vector_int2(0, 0), width: Int32(size.x), height: Int32(size.y), diagonalsAllowed: false, nodeClass: GKGridGraphNode.self)
        
        for node in graph.nodes! {
            let gridNode = node as! GKGridGraphNode
            let position = Vector(x: gridNode.gridPosition.x, y:gridNode.gridPosition.y)
            nodeMap[position] = gridNode
        }
        
        let nodesToRemove = cells
            .filter { $0.value.enterable == false }
            .compactMap { nodeMap[$0.key] }
        
        graph.remove(nodesToRemove)
        
        return (map: nodeMap, graph: graph)
    }
    
    func path(from coord1: Vector, to coord2: Vector) -> [Vector] {
        guard let fromNode = vectorNodeMap[coord1], let toNode = vectorNodeMap[coord2] else {
            print("Cant find vector from nodes dictionary")
            return []
        }
        
        let path = graph.findPath(from: fromNode, to: toNode)
        
        return path.map { node in
            let pos = (node as! GKGridGraphNode).gridPosition
            return Vector(x: pos.x, y: pos.y)
        }
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
    
    var blocksLight: Bool {
        switch self {
        case .floor:
            return false
        default:
            return true
        }
    }
    
}
