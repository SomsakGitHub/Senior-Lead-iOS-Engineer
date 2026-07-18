//✅ SwiftUI จะอัปเดตค่า UserDefaults ให้อัตโนมัติ
//และจำค่าทันทีแม้ปิด–เปิดแอปใหม่

import SwiftUI

struct ContentView: View {
    @AppStorage("username") var username: String = "Guest"
    
    var body: some View {
        VStack {
            Text("👋 สวัสดี \(username)")
            TextField("ชื่อผู้ใช้", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}


#Preview {
    ContentView()
}
