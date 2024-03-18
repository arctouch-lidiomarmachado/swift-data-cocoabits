//
//  ContentView.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI

struct ContentView: View {
    @State var items: [Item] = []
    @State var sort: SortDescriptor<Item> = SortDescriptor(\.itemTitle)
    
    var body: some View {
        NavigationStack {
            ItemListView(items: $items)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ItemDetailView(item: Item(), items: $items, exhibitionMode: .insert)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Items")
        }
    }
}

struct ItemListView: View {
    @Binding var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if items.isEmpty {
                ContentUnavailableView("Empty list",
                                       systemImage: "list.bullet")
            } else {
                List {
                    ForEach(items.indices, id: \.self) { index in
                        NavigationLink(destination: ItemDetailView(item: items[index], items: $items, exhibitionMode: .update)) {
                            HStack {
                                Text(items[index].itemTitle)
                                Spacer()
                                if items[index].isCompleted {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                        .font(.largeTitle)
                                } else {
                                    Image(systemName: "clock.fill")
                                        .foregroundStyle(.gray)
                                        .font(.largeTitle)
                                }
                            }
                        }
                    }.onDelete { indexSet in
                        for index in indexSet {
                            items.remove(at: index)
                        }
                    }
                }
            }
        }
    }
}
