//
//  Item.swift
//  GCD
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
