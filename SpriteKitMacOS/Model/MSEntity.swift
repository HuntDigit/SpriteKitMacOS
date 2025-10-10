//
//  MSEntity.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 10.10.2025.
//

import Foundation
import GameplayKit

class MSEntity: GKEntity {
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
}
