//
//  ACBookApp.swift
//  ACBook
//
//  Created by Lorenzo on 04/08/22.
//

import SwiftUI

@main
struct ACBookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
