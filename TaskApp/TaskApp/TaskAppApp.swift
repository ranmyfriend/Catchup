//
//  TaskAppApp.swift
//  TaskApp
//
//  Created by BKS-GGS on 27/09/21.
//

import SwiftUI

// Author: https://www.youtube.com/watch?v=gPqIE-nlxLA

@main
struct TaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
