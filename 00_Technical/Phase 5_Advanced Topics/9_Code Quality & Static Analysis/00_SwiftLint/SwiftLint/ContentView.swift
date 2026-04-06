//✅ SwiftLint คืออะไร?
//
//SwiftLint คือ เครื่องมือ Static Code Analysis สำหรับภาษา Swift
//เอาไว้ตรวจเช็กคุณภาพโค้ด เช่น
//
//รูปแบบโค้ดไม่ตรงมาตรฐาน
//
//force unwrap
//
//unused variable
//
//naming ไม่ตรง convention
//
//line length ยาวเกิน
//
//import ซ้ำ
//
//function ยาวเกินไป
//
//indentation ไม่ถูกต้อง
//
//💡 สรุป: ช่วยให้โค้ดทีมคุณ “สะอาด, อ่านง่าย, มาตรฐานเดียวกัน”

//🔧 วิธีติดตั้ง SwiftLint (แบบใช้จริงในโปรเจกต์ iOS ปี 2024–2025)
//1) ติดตั้งผ่าน Homebrew
//brew install swiftlint

//2) เพิ่มเข้า Xcode Build Phase
//
//ไปที่
//Your Target → Build Phases → + → New Run Script Phase
//
//ใส่ script นี้:
//
//if which swiftlint > /dev/null; then
//  swiftlint
//else
//  echo "error: SwiftLint not installed. Install with brew install swiftlint"
//fi

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

import Foundation


class SwiftLintDemo {     // <- type_name violation (ถ้าใช้ PascalCase / suffix Rule)
    
    var a = 10            // <- identifier_name (ชื่อสั้นเกินไป)
    var age:Int=20        // <- colon rule + spacing rule
    
    func testForceUnwrap() {
        let name: String? = nil
        print(name!)      // <- force_unwrapping
    }
    
    func testForceCast() {
        let value: Any = "Hello"
        let intValue = value as! Int   // <- force_cast
        print(intValue)
    }
    
    func veryLongLineExample() {
        let text = "This is a very very very very long text that should break the SwiftLint line_length rule because it exceeds 120 characters easily."
        print(text)
    }
    
    func unusedVariableExample() {
        let unused = 123  // <- unused_variable
    }
    
    func emptyCountExample() {
        let array: [Int] = []
        if array.count == 0 {    // <- empty_count (ควรใช้ array.isEmpty)
            print("Empty")
        }
    }
    
    
    // MARK: - function_body_length
    func longFunction() {
        print(1)
        print(2)
        print(3)
        print(4)
        print(5)
        print(6)
        print(7)
        print(8)
        print(9)
        print(10)
        print(11)
        print(12)
        print(13)
        print(14)
        print(15)
        print(16)
        print(17)
        print(18)
        print(19)
        print(20)
    }
    
    // Trailing whitespace (ทำให้เกิด warning)
    func trailingSpace() {
        print("Hello")
    }
}

