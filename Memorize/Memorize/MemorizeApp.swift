//
//  MemorizeApp.swift
//  Memorize
//
//  Created by BKS-GGS on 01/09/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                EmojiMemoryGameView(game: game)
            }
        }
    }
}
