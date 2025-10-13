//
//  PursuingState.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 12.10.2025.
//

import Foundation
import GameplayKit

final class PursuingState: GKState, WorldUpdateable, OwnedState {
    let owner: MSEntity
    var target: MSEntity
    
    init(owner: MSEntity, target: MSEntity) {
        self.owner = owner
        self.target = target
        
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        false
    }
    
    func update(in world: World) {
        var dx = 0
        var dy = 0
        
        if target.position.x > owner.position.x {
            dx = 1
        }
        if target.position.x < owner.position.x {
            dx = -1
        }
        if target.position.y > owner.position.y {
            dy = 1
        }
        if target.position.y < owner.position.y {
            dy = -1
        }
        
        let direction = Vector(x:dx, y:dy)
        if let newHeading = Heading.vectorToHeading(direction) {
            owner.heading = newHeading
        }
        
        _ = owner.tryMove(to: owner.heading.toVector, in: world.map)
    }
}
