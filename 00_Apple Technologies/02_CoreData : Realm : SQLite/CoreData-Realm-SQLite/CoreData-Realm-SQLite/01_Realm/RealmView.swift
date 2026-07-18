//✅ คืออะไร
//
//Realm เป็น mobile database แบบ object-based
//ใช้งานง่ายกว่า Core Data มาก
//และเร็วกว่า SQLite หลายเท่าในหลายกรณี

//Realm มี property wrapper (@ObservedResults) ที่ integrate กับ SwiftUI โดยตรง
//
//📌 จุดเด่น
//ใช้งานง่ายมาก (ไม่ต้อง context/save)
//เร็วมาก
//มี auto-sync (Realm Sync) ถ้าใช้ MongoDB Realm
//รองรับหลาย platform (iOS, Android)
//
//⚠️ ข้อจำกัด
//ต้องติดตั้ง library เพิ่ม
//ไม่ใช่ built-in (ต้อง bundle Realm framework)
//ไฟล์ใหญ่กว่า SQLite เล็กน้อย

//✅ บันทึกข้อมูล
//let realm = try! Realm()
//let note = Note()
//note.title = "My Realm Note"
//
//try! realm.write {
//    realm.add(note)
//}
//
//✅ ดึงข้อมูล
//let notes = realm.objects(Note.self)
//for note in notes {
//    print("📝 \(note.title)")
//}
//
//✅ ลบข้อมูล
//if let note = notes.first {
//    try! realm.write {
//        realm.delete(note)
//    }
//}

import SwiftUI
import RealmSwift

//✅ สร้าง Model
class Note: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var date: Date = Date()
}

struct RealmView: View {
    @ObservedResults(Note.self) var notes
        
        var body: some View {
            List {
                ForEach(notes) { note in
                    Text(note.title)
                }
            }
            .toolbar {
                Button("Add") {
                    $notes.append(Note(value: ["title": "New Note"]))
                }
                Button("Remove") {
                    if let note = notes.last {
                        $notes.remove(note)
                    }
                }
            }
        }
}

#Preview {
    RealmView()
}
