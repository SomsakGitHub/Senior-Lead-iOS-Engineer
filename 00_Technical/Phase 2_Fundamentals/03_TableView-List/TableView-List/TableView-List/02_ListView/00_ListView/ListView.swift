//
//  ListView.swift
//  TableView-List
//
//  Created by tiscomacnb2486 on 30/10/2568 BE.
//

import SwiftUI

struct ListView: View {
    let fruits = ["🍎 Apple", "🍌 Banana", "🍇 Grape", "🍊 Orange"]

    var body: some View {
        callList()
    }
    
    func callList() -> some View {
        return List(self.fruits, id: \.self) { fruit in
            Text(fruit)
        }
        .navigationTitle("ผลไม้")
        
//        🧱 List แบบมี Section
//        List {
//            Section(header: Text("ผลไม้")) {
//                Text("🍎 Apple")
//                Text("🍊 Orange")
//            }
//
//            Section(header: Text("สัตว์")) {
//                Text("🐶 Dog")
//                Text("🐱 Cat")
//            }
//        }
//        .listStyle(.insetGrouped)
        
//        ⚙️ List แบบ Interactive
//        List {
//            ForEach(fruits, id: \.self) { fruit in
//                Text(fruit)
//            }
//            .onDelete(perform: deleteItem)
//        }
//
//        func deleteItem(at offsets: IndexSet) {
//            // ลบข้อมูลที่ตำแหน่งที่เลือก
//        }
    }
}

#Preview {
    ListView()
}
