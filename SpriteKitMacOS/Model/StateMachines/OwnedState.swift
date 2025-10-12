//
//  OwnedState.swift.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 12.10.2025.
//
import Foundation
import GameplayKit

protocol OwnedState: GKState {
    var owner: MSEntity { get }
}
