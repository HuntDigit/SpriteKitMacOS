//
//  SKonsole.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 29.09.2025.
//

import Foundation
import SpriteKit

final class SKonsole: SKNode {

    let rowCount: Int
    let colCount: Int
    
    private var fgNodes = [SKSpriteNode]()
    private var textureCache: [String: SKTexture] = [:]

    init(rowCount: Int, colCount: Int) {
        self.rowCount = rowCount
        self.colCount = colCount
        
        super.init()
        
        let texture = SKTexture(imageNamed: "square_16x16")
        
        for y in 0..<rowCount{
            for x in 0..<colCount {
                let fgNode = SKSpriteNode(texture: texture)
                fgNode.position = CGPoint(x: 16 + 32 * x , y: 16 + 32 * y)
                fgNode.scale(to: CGSize(width: 32, height: 32))
                fgNode.colorBlendFactor = 1.0
                fgNode.color = SKColor(calibratedHue: CGFloat.random(in: 0 ... 1.0),
                                       saturation: 1.0,
                                       brightness: 1.0, alpha: 1.0)
                fgNodes.append(fgNode)
                addChild(fgNode)
            }
        }
        
    }
    
    func setCharacter(_ char: Character, at point: Vector) {
        let node = self.fgNodes[self.colCount * point.y + point.x]
        node.color = SKColor.white
        if let texture = textureCache[String(char)] {
            node.texture = texture
        } else {
            let key = ConverterTable.exchangeCharacter(char)
            let texture = SKTexture(imageNamed: key)
            texture.filteringMode = .nearest
            textureCache[String(char)] = texture
            node.texture = texture
        }
    }
    
    func setString(_ string: String, at point: Vector) {
        var dynamicPoint = point
        for ch in string {
            setCharacter(ch, at: dynamicPoint)
            dynamicPoint.x += 1
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
