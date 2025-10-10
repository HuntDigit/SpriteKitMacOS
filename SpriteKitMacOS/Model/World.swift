//
//  World.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation

class World {
    let map: Map
    let player: MSEntity
    var entities: [MSEntity] = []
    
    init(mapString: String) {
        map = Map(mapString: mapString)
        
        player = MSEntity(name: "Player", startPosition: map.playerStartPosition)
        entities.append(player)
        
        let targer = MSEntity(name: "Treasure", startPosition: map.targetPosition)
        entities.append(targer)
        
        for esp in map.enemySpawnPositions {
            let enemy = MSEntity(name: "Enemy", startPosition: esp)
            entities.append(enemy)
        }
    }
}
