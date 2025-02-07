//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Rabie on 07/02/2025.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
