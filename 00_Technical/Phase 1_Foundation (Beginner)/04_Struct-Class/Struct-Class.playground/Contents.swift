import UIKit

//1. Struct (โครงสร้างข้อมูล)
//คือ “ค่าข้อมูล” (Value Type)
//ทุกครั้งที่คุณ “คัดลอก” struct → Swift จะสร้าง สำเนาใหม่ แยกออกมาเลย

struct Person {
    var name: String
    var age: Int
    
    func greet() {
        print("Hello, my name is \(name).")
    }
}

var p1 = Person(name: "Somsak", age: 25)
var p2 = p1 // สร้างสำเนาใหม่
p2.name = "Mew"

print(p1.name) // Somsak
print(p2.name) // Mew (ค่าเปลี่ยนเฉพาะ p2)

//การเปลี่ยนค่าใน p2 ไม่กระทบ p1
//เพราะ struct เป็น “ค่าที่ถูกก็อป”

//2. Class (คลาส)
//คือ “อ้างอิงถึง object” (Reference Type)
//ทุกครั้งที่คุณ “คัดลอก” class → Swift จะสร้าง ตัวชี้ (reference) ไปยัง object เดิม

class Person0 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func greet() {
        print("Hello, my name is \(name).")
    }
}

var c1 = Person0(name: "Somsak", age: 25)
var c2 = c1 // อ้างอิง object เดียวกัน
c2.name = "Mew"

print(c1.name) // Mew ❗
print(c2.name) // Mew

//การเปลี่ยนค่าใน c2 ทำให้ c1 เปลี่ยนด้วย
//เพราะ class คือ “อ้างอิงถึง object เดียวกันในหน่วยความจำ”

