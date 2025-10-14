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
//        let direction = simpleEnemyBehavior(in: world)
        let direction = modernEnemyBehavior(in: world)
        moveTo(direction: direction, in: world)
    }
    
    func moveTo(direction: Vector, in world: World) {
        if let newHeading = Heading.vectorToHeading(direction) {
            owner.heading = newHeading
        }
        
        _ = owner.tryMove(to: owner.heading.toVector, in: world.map)
    }
    
    func modernEnemyBehavior(in world: World) -> Vector {
        let path = world.map.path(from: owner.position, to: target.position)
        guard path.count > 0 else {
            print("No valid path found")
            return .zero
        }
        let direction: Vector
        if path.count == 1 {
            direction = path[0] - owner.position
        } else {
            direction = path[1] - owner.position
        }
        return direction
    }
    
    @available(*, deprecated, renamed: "modernEnemyBehavior", message: "Use modern implementation instead")
    func simpleEnemyBehavior(in world: World) -> Vector {
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
        return Vector(x:dx, y:dy)
    }
}
