//
//  ItemEntity.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

struct ItemEntity: Identifiable, Equatable {
    let id: UUID
    let timestamp: Date
    
    init(id: UUID = UUID(), timestamp: Date) {
        self.id = id
        self.timestamp = timestamp
    }
}
