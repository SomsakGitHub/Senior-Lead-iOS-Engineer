//✅ คืออะไร

//SQLite เป็น ฐานข้อมูล SQL จริง ๆ
//ทำงานในเครื่อง (ไม่มี server)
//และเป็นพื้นฐานของ Core Data ด้วย
//เราสามารถใช้ผ่าน library เช่น SQLite.swift

import SwiftUI
//import SQLite

struct SQLiteView: View {
    
//    let db = try Connection("notes.sqlite3")
//
//    let notes = Table("notes")
//    let id = Expression<Int64>("id")
//    let title = Expression<String>("title")
//
//    try db.run(notes.create(ifNotExists: true) { t in
//        t.column(id, primaryKey: true)
//        t.column(title)
//    })
    
//    // ✅ Insert
//    try db.run(notes.insert(title <- "Hello SQLite"))
//
//    // ✅ Query
//    for note in try db.prepare(notes) {
//        print("🗒️ \(note[title])")
//    }
//
//    // ✅ Delete
//    try db.run(notes.delete())

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SQLiteView()
}
