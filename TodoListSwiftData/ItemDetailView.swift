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
