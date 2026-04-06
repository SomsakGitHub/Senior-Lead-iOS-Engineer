//
//  Modal.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct Modal: View {
    @State private var showingModal = false
    
    var body: some View {
        Button("เปิดหน้าตั้งค่า") {
            showingModal = true
        }
        .sheet(isPresented: $showingModal) {
            SettingsView()
        }
        
//    หรือแบบเต็มจอ:
//
//    .fullScreenCover(isPresented: $showingModal) {
//        SettingsView()
//    }
    }
}

#Preview {
    Modal()
}
