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
    let itemDetail: Item
    @Binding var items: [Item]
    @State private var item: Item
    @Environment(\.dismiss) var dismiss
    var exhibitionMode: ExhibitionMode
    
    init(item: Item, items: Binding<[Item]>, exhibitionMode: ExhibitionMode) {
        self.itemDetail = item
        self._items = items
        self._item = State(initialValue: item)
        self.exhibitionMode = exhibitionMode
    }
    
    var body: some View {
        Form {
            LabeledContent("Item:") {
                TextField("", text: $item.itemTitle)
            }
            LabeledContent("Completed:") {
                Toggle("", isOn: $item.isCompleted)
            }
        }.toolbar {
            Button("Save") {
                if exhibitionMode == .insert {
                    items.append(item)
                } else {
                    update()
                }
                dismiss()
            }
        }
    }
    
    private func update() {
        guard let firstItem = items.first(where: { $0.itemTitle == item.itemTitle
            && $0.isCompleted == item.isCompleted }) else { return }
        firstItem.itemTitle = item.itemTitle
        firstItem.isCompleted = item.isCompleted
        items.append(Item())
        items.removeLast()
    }
}
