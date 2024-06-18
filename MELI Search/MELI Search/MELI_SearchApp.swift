//
//  MELI_SearchApp.swift
//  MELI Search
//
//  Created by Fernando Campo Garcia on 18/06/24.
//

import SwiftUI

@main
struct MELI_SearchApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
