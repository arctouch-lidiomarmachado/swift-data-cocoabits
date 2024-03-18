//
//  ContentView.swift
//  TodoListSwiftData
//
//  Created by Lidiomar Machado on 08/03/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var path: [Item] = []
    @State var sort: SortDescriptor<Item> = SortDescriptor(\.itemTitle)
    
    var body: some View {
        NavigationStack(path: $path) {
            ItemListView()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("", systemImage: "plus") {
                        path.append(Item())
                    }
                }
            }
            .navigationDestination(for: Item.self) { item in
                ItemDetailView(item: item, exhibitionMode: .insert)
            }
            .navigationTitle("Items")
        }
    }
}

struct ItemListView: View {
//    @Query(filter: #Predicate<Item> { $0.isCompleted == false && $0.name == "Store" }, sort: [SortDescriptor(\Item.name, order: .forward)]) var items: [Item]
    @Query var items: [Item]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            if items.isEmpty {
                ContentUnavailableView("Empty list",
                                       systemImage: "list.bullet")
            } else {
                List {
                    ForEach(items) { item in
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

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let modelContainer = try! ModelContainer(for: Item.self, configurations: configuration)
    let modelContext = ModelContext(modelContainer)
    let items = [
        Item(itemTitle: "Item 1", isCompleted: true),
        Item(itemTitle: "Item 2", isCompleted: true),
        Item(itemTitle: "Item 3", isCompleted: false),
        Item(itemTitle: "Item 4", isCompleted: false)
    ]
    
    items.forEach { item in
        modelContext.insert(item)
        try! modelContext.save()
    }
    
    return ContentView().modelContainer(modelContainer)
}
