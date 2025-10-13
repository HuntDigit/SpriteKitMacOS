//
//  PatrollingState.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 12.10.2025.
//

import Foundation
import GameplayKit

final class PatrollingState: GKState, WorldUpdateable, OwnedState {
    let owner: MSEntity
    var target: MSEntity
    
    init(owner: MSEntity, target: MSEntity) {
        self.owner = owner
        self.target = target
        
        super.init()
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        stateClass is PursuingState.Type
    }
    
    func update(in world: World) {
        if let vc = owner.component(ofType: VisibilityComponent.self) {
            if vc.tileVisibility[target.position]?.isVisible ?? false {
                _ = stateMachine?.enter(PursuingState.self)
                return
            }
        }
        
        if owner.tryMove(to: owner.heading.toVector, in: world.map) == false {
            let newHeadingRawValue = (owner.heading.rawValue + 2) % Heading.allCases.count
            owner.heading = .init(rawValue: newHeadingRawValue)!
        }
    }
}
