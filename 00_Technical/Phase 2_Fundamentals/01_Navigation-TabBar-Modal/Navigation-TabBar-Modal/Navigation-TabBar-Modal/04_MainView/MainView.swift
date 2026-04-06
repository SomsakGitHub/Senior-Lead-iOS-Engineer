//
//  MainView.swift
//  Navigation-TabBar-Modal
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationStack {
                VStack {
                    Text("Home Page")
                    NavigationLink("Go to Details", destination: DetailView())
                }
                .navigationTitle("Home")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView()
}
