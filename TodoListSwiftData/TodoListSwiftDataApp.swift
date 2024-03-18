//
//  TodoListSwiftDataApp.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI
import SwiftData

@main
struct TodoListSwiftDataApp: App {
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Item.self, migrationPlan: ItemMigrationPlan.self)
        } catch {
            fatalError("Model container error...")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(modelContainer)
    }
}
