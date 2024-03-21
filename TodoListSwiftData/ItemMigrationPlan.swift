//
//  ItemMigrationPlan.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 09/03/24.
//

import Foundation
import SwiftData

struct ItemMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] = [ItemSchema1.self, ItemSchema2.self]
    
    static var stages: [MigrationStage] = [migrateFromV1toV2.self]
    
    static let migrateFromV1toV2 = MigrationStage.custom(fromVersion: ItemSchema1.self,
                                                         toVersion: ItemSchema2.self,
                                                         willMigrate: { removeDuplicates(context: $0)},
                                                         didMigrate: nil)
    
    
    private static func removeDuplicates(context: ModelContext) {
        let items = try! context.fetch(FetchDescriptor<ItemSchema1.Item>())

        var usedNames = Set<String>()

        for item in items {
            if usedNames.contains(item.itemTitle) {
                context.delete(item)
            }

            usedNames.insert(item.itemTitle)
        }

        try! context.save()
    }
}
