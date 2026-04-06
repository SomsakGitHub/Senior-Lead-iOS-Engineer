//
//  MainTabView.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("หน้าแรก")
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            Text("โปรไฟล์")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }

    }
}

#Preview {
    MainTabView()
}
