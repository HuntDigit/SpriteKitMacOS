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
    
    override func didMove(to view: SKView) {
        console = SKonsole(rowCount: ROW_COUNT, colCount: COL_COUNT)
        addChild(console)
        
        console.setString("Hello, world!", at: .init(x: 1, y: 1))
    }
 
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            break
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
