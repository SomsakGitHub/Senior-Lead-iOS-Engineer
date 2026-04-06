//
//  LocationManagerApp.swift
//  LocationManager
//
//  Created by tiscomacnb2486 on 13/11/2568 BE.
//

import SwiftUI

@main
struct LocationManagerApp: App {
    var body: some Scene {
        WindowGroup {
            VStack {
                LocationView()
                MapView()
                    .frame(height: 300)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }
            .padding()
        }
    }
}
