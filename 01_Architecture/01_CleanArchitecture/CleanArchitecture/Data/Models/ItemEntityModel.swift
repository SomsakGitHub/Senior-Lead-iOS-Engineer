//
//  ItemEntity+SwiftData.swift
//  CleanArchitecture
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftData

@Model
final class ItemEntityModel {
    var id: UUID
    var timestamp: Date
    
    init(id: UUID = UUID(), timestamp: Date) {
        self.id = id
        self.timestamp = timestamp
    }
    
    func toDomain() -> ItemEntity {
        ItemEntity(id: id, timestamp: timestamp)
    }
}
