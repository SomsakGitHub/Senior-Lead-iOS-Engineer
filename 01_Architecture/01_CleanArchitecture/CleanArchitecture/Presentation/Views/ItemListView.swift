//
//  ItemListView.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI

struct ItemListView: View {
    @StateObject private var viewModel: ItemListViewModel
    
    init(viewModel: ItemListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete { offsets in
                    Task {
                        await viewModel.deleteItems(at: offsets)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        Task {
                            await viewModel.addItem()
                        }
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .alert("Error", isPresented: .constant(viewModel.error != nil)) {
                Button("OK") { viewModel.error = nil }
            } message: {
                Text(viewModel.error ?? "")
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            await viewModel.loadItems()
        }
    }
}
