//
//  ProBierApp.swift
//  ProBier
//
//  Created by Hans-Christian Wollert on 13.07.23.
//

import SwiftUI

@main
struct ProBierApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
