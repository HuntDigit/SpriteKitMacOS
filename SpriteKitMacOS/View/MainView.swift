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
    private let config:SpriteOptions
    
    init(size: CGSize) {
        self.size = size
        self.config = SpriteOptions()
    }
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = size
        scene.scaleMode = .aspectFit
        return scene
    }

    var body: some View {
        SpriteView(scene: scene,
                   preferredFramesPerSecond: config.prefFPS,
                   options: config.options,
                   debugOptions: config.debugOptions)
// set frame if you want to provide static size 
//            .frame(width: size.width, height: size.height)
    }
}

// MARK: - Configuration struct for SpriteView -

struct SpriteOptions {
    typealias Options = SpriteView.Options
    typealias DebugOptions = SpriteView.DebugOptions
    
    let prefFPS: Int = 30
    
    let options: Options = [
        .ignoresSiblingOrder,
        .shouldCullNonVisibleNodes
    ]
    let debugOptions: DebugOptions = [
        .showsFPS,
        .showsNodeCount
    ]
}
