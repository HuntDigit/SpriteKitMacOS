//
//  World.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation
import GameplayKit

class World {
    let map: Map
    let player: MSEntity
    var entities: [MSEntity] = []
    
    var state: GameState = .playing
    
    init(mapString: String) {
        map = Map(mapString: mapString)
        
        player = MSEntity(name: "Player", startPosition: map.playerStartPosition)
        player.addComponent(VisibilityComponent(visionRange: 10))
        entities.append(player)
        
        let targer = MSEntity(name: "Treasure", startPosition: map.targetPosition)
        entities.append(targer)
        
        for esp in map.enemySpawnPositions {
            let enemy = MSEntity(name: "Enemy", startPosition: esp)
            enemy.addComponent(VisibilityComponent(visionRange: 4))
            enemy.addComponent(AISimplePatrollComponent(owner: enemy, target: player))
            entities.append(enemy)
        }
    }
    
    func update() {
        for  entity in entities {
            entity.update(in: self)
        }
        
        
        let ruleSystem = GKRuleSystem()
        ruleSystem.add([
            makeEnemyCoughtPlayerRule(),
            makePlayerReachTreasureRule()
        ])
 
        ruleSystem.state["world"] = self
        ruleSystem.evaluate()
        
        let mappedFacts = ruleSystem.facts.compactMap { $0 as? NSString }
        
        if mappedFacts.contains("playerCought") {
            state = .lost
        } else if mappedFacts.contains("treasureReached") {
            state = .won
        }
    }
    
    // MARK: - Rules -
    func makeEnemyCoughtPlayerRule() -> GKRule {
        GKRule { ruleSystem in
            guard let world = ruleSystem.state["world"] as? World else {
                fatalError()
            }
            let enemies = world.entities.filter { $0.name == "Enemy" }
            for enemy in enemies {
                if enemy.position == world.player.position {
                    return true
                }
            }
            
            return false
        } action: { ruleSystem in
            ruleSystem.assertFact(NSString(stringLiteral: "playerCought"))
        }
    }
    
    func makePlayerReachTreasureRule() -> GKRule {
        GKRule { ruleSystem in
            guard let world = ruleSystem.state["world"] as? World else {
                fatalError()
            }
            guard let treasure = world.entities.first(where: { $0.name == "Treasure" }) else {
                fatalError()
            }
            
            return world.player.position == treasure.position
        } action: { ruleSystem in
            ruleSystem.assertFact(NSString(stringLiteral: "treasureReached"))
        }
    }

}

enum GameState {
    case playing
    case won
    case lost
}
