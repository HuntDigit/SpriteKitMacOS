//
//  AISimplePatrollComponent.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 12.10.2025.
//

import Foundation
import GameplayKit

final class AISimplePatrollComponent: GKComponent, WorldUpdateable {
    let stateMachine: GKStateMachine
    
    init(owner: MSEntity, target: MSEntity) {
        stateMachine = GKStateMachine(states: [
            PatrollingState(owner: owner, target: target),
            PursuingState(owner: owner, target: target)
        ])
        stateMachine.enter(PatrollingState.self)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(in world: World) {
        stateMachine.update(in: world)
    }
}
