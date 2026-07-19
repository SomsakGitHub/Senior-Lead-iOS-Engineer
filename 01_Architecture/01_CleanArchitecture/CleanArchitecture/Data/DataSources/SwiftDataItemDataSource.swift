//
//  SwiftDataItemDataSource.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftData

protocol ItemDataSource {
    func fetchAll() throws -> [ItemEntityModel]
    func insert(_ item: ItemEntityModel) throws
    func delete(id: UUID) throws
}

final class SwiftDataItemDataSource: ItemDataSource {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchAll() throws -> [ItemEntityModel] {
        let descriptor = FetchDescriptor<ItemEntityModel>(sortBy: [SortDescriptor(\.timestamp, order: .reverse)])
        return try modelContext.fetch(descriptor)
    }
    
    func insert(_ item: ItemEntityModel) throws {
        modelContext.insert(item)
        try modelContext.save()
    }
    
    func delete(id: UUID) throws {
        let descriptor = FetchDescriptor<ItemEntityModel>(predicate: #Predicate { $0.id == id })
        guard let item = try modelContext.fetch(descriptor).first else { return }
        modelContext.delete(item)
        try modelContext.save()
    }
}
