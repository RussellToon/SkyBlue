//
//  SkyBlueApp.swift
//  SkyBlue
//
//  Created by Russell Toon on 14/10/2024.
//

import SwiftUI
import SwiftData

@main
struct SkyBlueApp: App {

    /* TODO:
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Bookmark.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
     */


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(sharedModelContainer)
    }
}
