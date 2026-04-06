//
//  LayoutInLayout.swift
//  Auto Layout-SwiftUI
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct LayoutInLayout: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Profile")
                .font(.largeTitle)

            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 60))
                VStack(alignment: .leading) {
                    Text("Somsak")
                        .font(.headline)
                    Text("iOS Developer")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    LayoutInLayout()
}
