//
//  Navigation.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct Navigation: View {
    var body: some View {
//        NavigationStack {
            VStack {
                Text("หน้าหลัก")
                NavigationLink("ไปหน้ารายละเอียด") {
                    DetailView()
                }
            }
            .navigationTitle("Home")
//        }
    }
}

//กลับอัตโนมัติด้วย “Back Button” ที่ SwiftUI สร้างให้เอง ✅

#Preview {
    Navigation()
}
