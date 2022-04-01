//
//  icaloriesApp.swift
//  icalories
//
//  Created by BKS-GGS on 28/03/22.
//

import SwiftUI

@main
struct icaloriesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
