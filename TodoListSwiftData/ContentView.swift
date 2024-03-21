//
//  ContentView.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var items: [Item] = []
    @State var path: [Item] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            ItemListView()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        path.append(Item())
                    }
                }
            }.navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item, exhibitionMode: .insert)
            }
            .navigationTitle("Items")
        }
    }
}

struct ItemListView: View {
    @Query var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if items.isEmpty {
                ContentUnavailableView("Empty list",
                                       systemImage: "list.bullet")
            } else {
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink(destination: ItemDetailView(item: item, exhibitionMode: .update)) {
                            HStack {
                                Text(item.itemTitle)
                                Spacer()
                                if item.isCompleted {
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
                            modelContext.delete(items[index])
                        }
                    }
                }
            }
        }
    }
}
