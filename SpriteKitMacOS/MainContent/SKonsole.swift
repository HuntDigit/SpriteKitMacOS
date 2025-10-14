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
    private var bgNodes = [SKSpriteNode]()

    private var textureCache: [String: SKTexture] = [:]

    init(rowCount: Int, colCount: Int) {
        self.rowCount = rowCount
        self.colCount = colCount
        
        super.init()
        
        let texture = SKTexture(imageNamed: "square_16x16")
        texture.filteringMode = .nearest
        
        for y in 0..<rowCount{
            for x in 0..<colCount {
                let fgNode = SKSpriteNode(texture: texture)
                fgNode.position = CGPoint(x: 16 + 32 * x , y: 16 + 32 * y)
                fgNode.scale(to: CGSize(width: 32, height: 32))
                fgNode.colorBlendFactor = 1.0
                fgNode.color = SKColor(calibratedHue: CGFloat.random(in: 0 ... 1.0),
                                       saturation: 1.0,
                                       brightness: 1.0, alpha: 1.0)
                fgNode.zPosition = 0
                fgNodes.append(fgNode)
                addChild(fgNode)
                
                let bgNode = SKSpriteNode(texture: texture)
                bgNode.position = CGPoint(x: 16 + 32 * x , y: 16 + 32 * y)
                bgNode.scale(to: CGSize(width: 32, height: 32))
                bgNode.colorBlendFactor = 1.0
                bgNode.color = SKColor(calibratedHue: CGFloat.random(in: 0 ... 1.0),
                                       saturation: 1.0,
                                       brightness: 1.0, alpha: 1.0)
                bgNode.zPosition = -1
                bgNodes.append(bgNode)
                addChild(bgNode)
            }
        }
        
    }
    
    func putForeground(_ textureName: String, at point: Vector, offset: Vector,  fgColor: SKColor = .white) {
        let calibratedPoint = point + offset
        let node = self.fgNodes[self.colCount * calibratedPoint.y + calibratedPoint.x]
        node.texture = getTextureFromCache(textureName)
        
        node.isHidden = false
        node.color = fgColor
    }
    
    func putBackground(_ textureName: String, at point: Vector, offset: Vector, bgColor: SKColor = .white) {
        let calibratedPoint = point + offset
        let node = self.bgNodes[self.colCount * calibratedPoint.y + calibratedPoint.x]
        node.texture = getTextureFromCache(textureName)
        
        node.isHidden = false
        node.color = bgColor
    }
    
    func putCharacter(_ char: Character, at point: Vector, fgColor: SKColor = .white, bgColor: SKColor? = nil) {
        let textureName = ConverterTable.exchangeCharacter(char)
        putForeground(textureName, at: point, offset: .zero, fgColor: fgColor)
        
        if let bgColor = bgColor {
            putBackground("square_16x16", at: point, offset: .zero, bgColor: bgColor)
        }
     }
    
    func putString(_ string: String, at point: Vector, fgColor: SKColor = .white, bgColor: SKColor? = nil, alignment: Alignment = .left) {
        var cursor = point
        if alignment == .center {
            cursor.x = colCount/2 - string.count/2
        }
        
        for ch in string {
            putCharacter(ch, at: cursor, fgColor: fgColor, bgColor: bgColor)
            cursor.x += 1
        }
    }
    
    func clear() {
        for node in fgNodes {
            node.texture = nil
            node.isHidden = true
        }
        
        for node in bgNodes {
            node.texture = nil
            node.isHidden = true
        }
    }
    
    func getTextureFromCache(_ textureName: String) -> SKTexture {
        if let texture = textureCache[textureName] {
            return texture
        } else {
            let texture = SKTexture(imageNamed: textureName)
            texture.filteringMode = .nearest
            textureCache[textureName] = texture
            return texture
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum Alignment {
        case center
        case left
    }
}
