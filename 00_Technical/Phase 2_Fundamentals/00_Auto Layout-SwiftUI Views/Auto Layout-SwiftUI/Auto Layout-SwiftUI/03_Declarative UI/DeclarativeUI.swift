//
//  DeclarativeUI.swift
//  Auto Layout-SwiftUI
//
//  Created by tiscomacnb2486 on 25/10/2568 BE.
//

import SwiftUI

struct DeclarativeUI: View {
    var body: some View {
        VStack {
            Text("Hello SwiftUI")
                .font(.title)
            Button("Tap me!") {
                print("Tapped")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

#Preview {
    DeclarativeUI()
}
