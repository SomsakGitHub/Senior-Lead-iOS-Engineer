import UIKit

//1. if / else — เงื่อนไขพื้นฐาน
//ใช้ตรวจสอบ “เงื่อนไข” ว่าจริงหรือไม่ แล้วสั่งให้โค้ดทำงานตามนั้น

let score = 85

if score >= 90 {
    print("A")
} else if score >= 80 {
    print("B")
} else {
    print("C")
}

//✅ เงื่อนไขต้องเป็น Bool เสมอ
//❌ ไม่มีวงเล็บรอบเงื่อนไข (ต่างจาก C / Java)

//2. for-in — วนซ้ำในช่วงหรือรายการ
//ใช้วนลูปกับ ช่วงของตัวเลข (Range), Array, Dictionary ฯลฯ
//วนตามช่วงตัวเลข

for i in 1...5 { // 1 ถึง 5
    print(i)
}
// Output: 1 2 3 4 5
//ใช้ 1..<5 ถ้าอยากให้ “ไม่รวม 5”

//วนใน Array
let fruits = ["Apple", "Banana", "Orange"]

for fruit in fruits {
    print(fruit)
}

//วนใน Dictionary
let person = ["name": "Somsak", "age": "25"]

for (key, value) in person {
    print("\(key): \(value)")
}

//3. while — วนซ้ำจนกว่าเงื่อนไขจะไม่เป็นจริง
//ใช้เมื่อไม่รู้จำนวนรอบแน่นอนล่วงหน้า

var count = 0

while count < 3 {
    print("Round \(count)")
    count += 1
}

//4. repeat-while — ทำก่อน ตรวจทีหลัง
//เหมือน do-while ในภาษาอื่น
//คือจะ “ทำอย่างน้อยหนึ่งครั้งเสมอ”

var number = 0

repeat {
    print("Number: \(number)")
    number += 1
} while number < 3

//5. switch — ตรวจหลายเงื่อนไขแบบสวย ๆ
//ใช้แทน if-else หลาย ๆ ชั้นให้อ่านง่ายขึ้น
//Swift’s switch ทรงพลังมาก เพราะรองรับ pattern matching

let grade = "B"

switch grade {
case "A":
    print("Excellent!")
case "B", "C":
    print("Good job!")
case "D":
    print("Try harder.")
default:
    print("Invalid grade.")
}

//✅ ต้องครอบคลุมทุกกรณี — ถ้าไม่ครบ ให้ใส่ default
//✅ ไม่ต้องมี break (Swift จะหยุดให้เองอัตโนมัติ)

let score0 = 76

switch score0 {
case 90...100:
    print("A")
case 80..<90:
    print("B")
case 70..<80:
    print("C")
default:
    print("D")
}

//Switch แบบ Tuple (ตรวจหลายค่าในคราวเดียว)
let position = (x: 0, y: 0)

switch position {
case (0, 0):
    print("Origin")
case (_, 0):
    print("On X-axis")
case (0, _):
    print("On Y-axis")
default:
    print("Somewhere else")
}




