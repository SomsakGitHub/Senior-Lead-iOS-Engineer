//
//  CleanArchitectureApp.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import SwiftUI
import SwiftData

@main
struct CleanArchitectureApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ItemEntityModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ItemListView(viewModel: DependencyContainer(modelContext: modelContext).makeItemListViewModel())
    }
}
