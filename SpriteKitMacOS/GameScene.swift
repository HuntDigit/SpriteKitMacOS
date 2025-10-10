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
 
    func showWorld() {
        console.clear()
        for cell in world.map.cells {
            if cell.value != .void {
                console.putBackground(cell.value.name, at: cell.key, bgColor: .lightGray)
            }
        }
        
        for entity in world.entities {
            console.putForeground(entity.name, at: entity.position, fgColor: .white)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31: // ?
            break
        case 0x13: // W
            vector.y += 1
            break
        case 0x00: // A
            vector.x -= 1
            break
        case 0x20: // D
            vector.x += 1
            break
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
