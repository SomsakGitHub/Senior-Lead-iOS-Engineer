//
//  ItemRepository.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

protocol ItemRepository {
    func fetchAll() async throws -> [ItemEntity]
    func insert(timestamp: Date) async throws
    func delete(id: UUID) async throws
}
