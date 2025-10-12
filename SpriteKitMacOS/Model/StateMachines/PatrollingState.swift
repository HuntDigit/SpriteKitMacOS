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
        
    }
}
