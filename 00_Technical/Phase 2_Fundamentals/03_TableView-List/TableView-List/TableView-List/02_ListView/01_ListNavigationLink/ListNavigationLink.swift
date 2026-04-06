//
//  ListNavigationLink.swift
//  TableView-List
//
//  Created by tiscomacnb2486 on 30/10/2568 BE.
//

import SwiftUI

struct ListNavigationLink: View {
    let fruits = ["Apple", "Banana", "Grape"]

    var body: some View {
        NavigationStack {
            List(fruits, id: \.self) { fruit in
                NavigationLink(destination: Text("คุณเลือก \(fruit)")) {
                    Text(fruit)
                }
            }
            .navigationTitle("รายการผลไม้")
        }
    }
}

#Preview {
    ListNavigationLink()
}
