//
//  ItemUseCases.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

protocol FetchItemsUseCase {
    func execute() async throws -> [ItemEntity]
}

protocol AddItemUseCase {
    func execute(timestamp: Date) async throws
}

protocol DeleteItemUseCase {
    func execute(id: UUID) async throws
}

final class FetchItemsUseCaseImpl: FetchItemsUseCase {
    private let repository: ItemRepository
    
    init(repository: ItemRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [ItemEntity] {
        try await repository.fetchAll()
    }
}

final class AddItemUseCaseImpl: AddItemUseCase {
    private let repository: ItemRepository
    
    init(repository: ItemRepository) {
        self.repository = repository
    }
    
    func execute(timestamp: Date) async throws {
        try await repository.insert(timestamp: timestamp)
    }
}

final class DeleteItemUseCaseImpl: DeleteItemUseCase {
    private let repository: ItemRepository
    
    init(repository: ItemRepository) {
        self.repository = repository
    }
    
    func execute(id: UUID) async throws {
        try await repository.delete(id: id)
    }
}
