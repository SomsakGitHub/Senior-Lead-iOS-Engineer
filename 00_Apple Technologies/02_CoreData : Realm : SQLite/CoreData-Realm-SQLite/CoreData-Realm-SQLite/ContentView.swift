import SwiftUI
import CoreData

struct ContentView: View {
    
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        NavigationStack {
            // ปุ่มกดแล้ว push ไปหน้าใหม่
            NavigationLink("CoreDataView") {
                CoreDataView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            .buttonStyle(.borderedProminent)
            
            // ปุ่มกดแล้ว push ไปหน้าใหม่
            NavigationLink("RealmView") {
                RealmView()
            }
            .buttonStyle(.borderedProminent)
            
            // ปุ่มกดแล้ว push ไปหน้าใหม่
            NavigationLink("SQLiteView") {
                SQLiteView()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ContentView()
}
