//
//  GameScene.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 29.09.2025.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let COL_COUNT: Int = 80
    let ROW_COUNT: Int = 44
    
    var console: SKonsole!
    var world: World!
    
    var vector: Vector = .zero
    
    override func didMove(to view: SKView) {
        console = SKonsole(rowCount: ROW_COUNT, colCount: COL_COUNT)
        world = World(mapString: Map.mapString[0])

        addChild(console)
        console.clear()
        showWorld()
        
//        console.putString("Hello, world!", at: .init(x: 1, y: 1), bgColor: .black)
//        console.putForeground("Player", at: .init(x: 3, y: 8), fgColor: .green)
    }
    
    func resetGame() {
        world = World(mapString: Map.mapString[0])
        console.clear()
        showWorld()
    }
    
    func showWorld() {
        console.clear()
        world.update()
  
        if let vc = world.player.component(ofType: VisibilityComponent.self) {
            for tile in vc.tileVisibility {
                let mapCell = world.map.getCell(tile.key)
                
                switch tile.value {
                case .notVisited:
                    break
                case .visited:
                    console.putBackground(mapCell.name, at: tile.key, bgColor: .darkGray)
                case .visible(let lit):
                    let color = SKColor(calibratedHue: 0.5, saturation: 1, brightness: lit, alpha: 1)
                    console.putBackground(mapCell.name, at: tile.key, bgColor: color)
                }
            }
            
            let intersectVCs = world.entities
                .filter { $0 != world.player }
                .compactMap { $0.component(ofType: VisibilityComponent.self) }
            
            for intersectVC in intersectVCs {
                let overlapTiles = overlaingTiles(vc.tileVisibility, intersectVC.tileVisibility)
                
                for tile in overlapTiles {
                    let mapCell = world.map.getCell(tile.key)
                    
                    switch tile.value {
                    case .notVisited:
                        break
                    case .visited:
                        break
                    case .visible(let lit):
                        let color = SKColor(calibratedHue: 0.0, saturation: 1, brightness: lit, alpha: 1)
                        console.putBackground(mapCell.name, at: tile.key, bgColor: color)
                    }
                }
            }
            
            for entity in world.entities {
                let visibility = vc.tileVisibility[entity.position, default: .notVisited]
                switch visibility {
                case .notVisited:
                    break
                case .visited:
                    break
                case .visible(let lit):
                    let color = SKColor(calibratedHue: 0.1, saturation: 1, brightness: lit, alpha: 1)
                    console.putForeground(entity.name, at: entity.position, fgColor: color)
                }
            }
        }
    }
    
    func overlaingTiles(_ tiles1:[Vector: Visibility], _ tiles2: [Vector: Visibility]) -> [Vector: Visibility] {
        let visibleTiles1 = tiles1.filter { $0.value.isVisible }
        let visibleTiles2 = tiles2.filter { $0.value.isVisible }
        
        let coordSet1 = Set(visibleTiles1.keys)
        let coordSet2 = Set(visibleTiles2.keys)
        
        let intersection = coordSet1.intersection(coordSet2)
        var result = [Vector: Visibility]()
        for coord in intersection {
            result[coord] = tiles1[coord]
        }
        
        return result
    }
    
    override func keyDown(with event: NSEvent) {
        var direction: Vector = .zero
        switch event.keyCode {
        case 0, 123: // A - left
            direction = .left
        case 2, 124: // D - right
            direction = .right
        case 13, 126: // W - up
            direction = .up
        case 1, 125: // S - down
            direction = .down
        case 53: // ESC
            resetGame()
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
        
        if world.player.tryMove(to: direction, in: world.map) {
            showWorld()
        } else {
            console.putString("!BOINK!", at: .zero)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
