//
//  ItemDetailView.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI

enum ExhibitionMode {
    case insert
    case update
}

struct ItemDetailView: View {
    let item: Item
    @Binding var items: [Item]
    @State private var dynamicItem: Item
    @Environment(\.dismiss) var dismiss
    var exhibitionMode: ExhibitionMode
    
    init(item: Item, items: Binding<[Item]>, exhibitionMode: ExhibitionMode) {
        self.item = item
        self._items = items
        self._dynamicItem = State(initialValue: item)
        self.exhibitionMode = exhibitionMode
    }
    
    var body: some View {
        Form {
            LabeledContent("Item:") {
                TextField("", text: $dynamicItem.itemTitle)
            }
            LabeledContent("Completed:") {
                Toggle("", isOn: $dynamicItem.isCompleted)
            }
        }.toolbar {
            Button("Save") {
                if exhibitionMode == .insert {
                    items.append(dynamicItem)
                } else {
                    update()
                }
                dismiss()
            }
        }
    }
    
    private func update() {
        guard let item = items.first(where: { $0.itemTitle == dynamicItem.itemTitle
            && $0.isCompleted == dynamicItem.isCompleted }) else { return }
        item.itemTitle = dynamicItem.itemTitle
        item.isCompleted = dynamicItem.isCompleted
        items.append(Item())
        items.removeLast()
    }
}
