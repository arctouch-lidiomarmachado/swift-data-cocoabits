//
//  Item.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import Foundation

class Item {
    var itemTitle: String
    var isCompleted: Bool
    
    init(itemTitle: String = "", isCompleted: Bool = false) {
        self.itemTitle = itemTitle
        self.isCompleted = isCompleted
    }
}
