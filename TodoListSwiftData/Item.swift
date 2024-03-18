//
//  Item.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import Foundation

class Item: Hashable {
    var itemTitle: String
    var isCompleted: Bool
    
    init(itemTitle: String = "", isCompleted: Bool = false) {
        self.itemTitle = itemTitle
        self.isCompleted = isCompleted
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemTitle)
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.isCompleted == rhs.isCompleted && lhs.itemTitle == rhs.itemTitle
    }
}
