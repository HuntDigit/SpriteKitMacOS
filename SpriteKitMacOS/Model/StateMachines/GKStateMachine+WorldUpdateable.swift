//
//  GKStateMachine+WorldUpdateable.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 12.10.2025.
//

import Foundation
import GameplayKit

extension GKStateMachine: WorldUpdateable {
    func update(in world: World) {
        guard let currentWorldUpdateableState = currentState as? WorldUpdateable else {
            fatalError("Current state is not WorldUpdateable")
        }
        
        currentWorldUpdateableState.update(in: world)
    }
}
