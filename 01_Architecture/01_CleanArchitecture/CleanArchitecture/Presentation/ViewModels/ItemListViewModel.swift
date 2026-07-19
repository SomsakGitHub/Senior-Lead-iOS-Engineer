//
//  ItemListViewModel.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import Combine

@MainActor
final class ItemListViewModel: ObservableObject {
    @Published var items: [ItemEntity] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let fetchItemsUseCase: FetchItemsUseCase
    private let addItemUseCase: AddItemUseCase
    private let deleteItemUseCase: DeleteItemUseCase
    
    init(
        fetchItemsUseCase: FetchItemsUseCase,
        addItemUseCase: AddItemUseCase,
        deleteItemUseCase: DeleteItemUseCase
    ) {
        self.fetchItemsUseCase = fetchItemsUseCase
        self.addItemUseCase = addItemUseCase
        self.deleteItemUseCase = deleteItemUseCase
    }
    
    func loadItems() async {
        isLoading = true
        error = nil
        do {
            items = try await fetchItemsUseCase.execute()
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func addItem() async {
        do {
            try await addItemUseCase.execute(timestamp: Date())
            await loadItems()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func deleteItems(at offsets: IndexSet) async {
        let idsToDelete = offsets.map { items[$0].id }
        for id in idsToDelete {
            do {
                try await deleteItemUseCase.execute(id: id)
            } catch {
                self.error = error.localizedDescription
            }
        }
        await loadItems()
    }
}
