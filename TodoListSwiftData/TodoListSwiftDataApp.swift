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
    
//    var modelContainer: ModelContainer {
//        return try! ModelContainer(for: Item.self, migrationPlan: ItemMigrationPlan.self)
//    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(for: Item.self)
    }
}
