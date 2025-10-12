//
//  MSEntity.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation
import GameplayKit

class MSEntity: GKEntity, WorldUpdateable {
    var position = Vector.zero
    let name: String
    
    init(name: String, startPosition: Vector = .zero) {
        self.name = name
        self.position = startPosition
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tryMove(to: Vector, in map: Map) -> Bool {
        let newPosition = position + to
        
        if map.getCell(newPosition).enterable {
            position = newPosition
            return true
        }
        
        return false
    }
    
    func update(in world: World) {
        let worldUpdatableComponents = components.compactMap { $0 as? WorldUpdateable }
        
        for component in worldUpdatableComponents {
            component.update(in: world)
        }
    }
}

extension GKComponent {
    
    var msEntity: MSEntity {
        guard let entity = entity as? MSEntity else {
            fatalError("Entity is not of type MSEntity")
        }
        
        return entity
    }
}
