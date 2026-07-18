//✅ คืออะไร
//Core Data ไม่ใช่แค่ database —
//มันคือ object graph management framework
//ที่ช่วยเราจัดการ model objects (เช่น User, Note, Product) ได้สะดวก
//และจะจัดการการเก็บใน SQLite ให้เอง

//✅ สร้างและใช้งาน (UIKit / SwiftUI)
//1️⃣ สร้าง Model (Entity)
//
//ใน Xcode:
//File → New → File → Data Model → สร้าง Model.xcdatamodeld
//เพิ่ม Entity ชื่อ Note
//และใส่ Attributes:
//title: String
//date: Date

//📌 จุดเด่น

//เขียน query แบบ object-oriented (ไม่ต้อง SQL)
//มี integration กับ SwiftUI ผ่าน @FetchRequest
//รองรับ migration, relationship, และ performance ดีมาก

//⚠️ ข้อจำกัด
//มี learning curve สูง
//ถ้าแอปเล็ก อาจดูซับซ้อนเกินจำเป็น

import SwiftUI
import CoreData

struct CoreDataView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    } label: {
                        Text(item.timestamp!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    CoreDataView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

