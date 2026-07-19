//
//  DependencyContainer.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftData

final class DependencyContainer {
    let fetchItemsUseCase: FetchItemsUseCase
    let addItemUseCase: AddItemUseCase
    let deleteItemUseCase: DeleteItemUseCase
    
    init(modelContext: ModelContext) {
        let dataSource = SwiftDataItemDataSource(modelContext: modelContext)
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        self.fetchItemsUseCase = FetchItemsUseCaseImpl(repository: repository)
        self.addItemUseCase = AddItemUseCaseImpl(repository: repository)
        self.deleteItemUseCase = DeleteItemUseCaseImpl(repository: repository)
    }
    
    func makeItemListViewModel() -> ItemListViewModel {
        ItemListViewModel(
            fetchItemsUseCase: fetchItemsUseCase,
            addItemUseCase: addItemUseCase,
            deleteItemUseCase: deleteItemUseCase
        )
    }
}
