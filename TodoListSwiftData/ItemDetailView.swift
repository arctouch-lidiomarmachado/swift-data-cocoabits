//
//  ItemDetailView.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI
import SwiftData

enum ExhibitionMode {
    case insert
    case update
}

struct ItemDetailView: View {
    @Bindable var item: Item
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    var exhibitionMode: ExhibitionMode
    
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
                    modelContext.insert(item)
                }
                dismiss()
            }
        }
    }
}

#Preview {
    let modelConfig = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Item.self, configurations: modelConfig)
    
    let item = Item(itemTitle: "", isCompleted: false)
    
    return ItemDetailView(item: item, exhibitionMode: .insert).modelContainer(modelContainer)
}
