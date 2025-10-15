//
//  MainApp.swift
//  SpriteKitMacOS
//
//  Created by Andrii Sabinin on 29.09.2025.
//

import SwiftUI

@main
struct MainApp: App {
    //We can add AppDelegate later if nedded as property wrapper
    private let windowSize = CGSize(width: 1280, height: 768)
    
    var body: some Scene {
        WindowGroup {
            MainView(size: windowSize)
        }
        .windowResizability(.contentMinSize)
    }
}
