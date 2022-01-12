//
//  RecipeSaverApp.swift
//  RecipeSaver
//
//  Created by BKS-GGS on 07/01/22.
//

import SwiftUI

@main
struct RecipeSaverApp: App {
    @StateObject private var recipesViewModel = RecipesViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipesViewModel)
        }
    }
}
