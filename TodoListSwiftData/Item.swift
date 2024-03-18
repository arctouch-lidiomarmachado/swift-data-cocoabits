//
//  Item.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import Foundation
import SwiftData

typealias Item = ItemSchema2.Item

enum ItemSchema1: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    @Model
    class Item {
        @Attribute(originalName: "name")
        var itemTitle: String
        var isCompleted: Bool
        
        init(itemTitle: String = "", isCompleted: Bool = false) {
            self.itemTitle = itemTitle
            self.isCompleted = isCompleted
        }
    }
}

enum ItemSchema2: VersionedSchema {
    static var models: [any PersistentModel.Type] = [Item.self]
    
    static var versionIdentifier: Schema.Version = Schema.Version(2, 0, 0)
    
    @Model
    class Item {
        @Attribute(.unique, originalName: "name")
        var itemTitle: String
        var isCompleted: Bool
        
        init(itemTitle: String = "", isCompleted: Bool = false) {
            self.itemTitle = itemTitle
            self.isCompleted = isCompleted
        }
    }
}
