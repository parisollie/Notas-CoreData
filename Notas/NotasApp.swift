//
//  NotasApp.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//

import SwiftUI

@main
struct NotasApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

