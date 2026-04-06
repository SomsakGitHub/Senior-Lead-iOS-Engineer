//
//  AlignmentFrame.swift
//  Auto Layout-SwiftUI
//
//  Created by tiscomacnb2486 on 26/10/2568 BE.
//

import SwiftUI

struct AlignmentFrame: View {
    var body: some View {
        Text("Hello")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
    }
}

//    .frame → กำหนดขนาด/ตำแหน่ง
//
//    .padding → เพิ่มช่องว่าง
//
//    .alignmentGuide → ปรับ alignment ละเอียดได้

#Preview {
    AlignmentFrame()
}
