//
//  MainView.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 14.10.2025.
//

import SwiftUI
import SpriteKit

struct MainView: View {
    let size: CGSize
    
    private let preferredFramesPerSecond: Int = 30
    private let options: SpriteView.Options = [
        .ignoresSiblingOrder,
        .shouldCullNonVisibleNodes
    ]
    private let debugOptions: SpriteView.DebugOptions = [
        .showsFPS,
        .showsNodeCount
    ]
    
    init(size: CGSize) {
        self.size = size
    }
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .aspectFit
        return scene
    }

    var body: some View {
        SpriteView(scene: scene,
                   preferredFramesPerSecond: preferredFramesPerSecond,
                   options: options,
                   debugOptions: debugOptions)
            .frame(width: size.width, height: size.height)
            .ignoresSafeArea()
    }
}
