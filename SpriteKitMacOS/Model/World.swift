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
    }
}
