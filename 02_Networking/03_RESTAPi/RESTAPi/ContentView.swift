//
//  ContentView.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            PostListView()
                .tabItem {
                    Label("Posts", systemImage: "list.bullet")
                }
            
            LocalItemsView()
                .tabItem {
                    Label("Local Items", systemImage: "internaldrive")
                }
        }
    }
}

struct LocalItemsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Local Items")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
