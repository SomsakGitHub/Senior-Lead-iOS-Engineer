//
//  ItemRepositoryImpl.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

final class ItemRepositoryImpl: ItemRepository {
    private let dataSource: ItemDataSource
    
    init(dataSource: ItemDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchAll() async throws -> [ItemEntity] {
        try dataSource.fetchAll().map { $0.toDomain() }
    }
    
    func insert(timestamp: Date) async throws {
        let model = ItemEntityModel(timestamp: timestamp)
        try dataSource.insert(model)
    }
    
    func delete(id: UUID) async throws {
        try dataSource.delete(id: id)
    }
}
