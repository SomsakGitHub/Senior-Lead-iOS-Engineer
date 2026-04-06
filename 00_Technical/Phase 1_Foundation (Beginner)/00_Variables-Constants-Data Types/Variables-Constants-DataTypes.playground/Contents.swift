import UIKit

//1. Variables (ตัวแปร)
//ใช้เก็บข้อมูลที่สามารถ เปลี่ยนค่าได้

var name = "Somsak"
name = "Mew" // ✅ เปลี่ยนค่าได้

//ใช้คำว่า var
//Swift จะ “เดา type” ให้โดยอัตโนมัติ
//แต่เราก็สามารถระบุ type เองได้ เช่น:

var age: Int = 25
var city: String = "Bangkok"

//2. Constants (ค่าคงที่)
//ใช้เก็บข้อมูลที่ ห้ามเปลี่ยนค่า

let pi = 3.14159
// pi = 3.14 ❌ error — เพราะเป็น constant

//ใช้ let
//ใช้บ่อยมาก เพราะช่วยให้โค้ดปลอดภัยและชัดเจนขึ้น

//3. Data Types (ชนิดข้อมูลพื้นฐาน)
var age0: Int = 25          // จำนวนเต็ม
var height: Double = 175.5 // ทศนิยม (64-bit)
var weight: Float = 70.2   // ทศนิยม (32-bit)

var name0: String = "Somsak"
let greeting = "Hello, \(name)!" // String interpolation

var isOnline: Bool = true
var isLoggedIn = false

var fruits = ["Apple", "Banana", "Orange"]
print(fruits[1]) // Banana

var person = ["name": "Somsak", "age": "25"]
print(person["name"] ?? "") // Somsak

var nickname: String? = nil
nickname = "Mew"
print(nickname ?? "No nickname") // ใช้ ?? เพื่อใส่ค่า default

//4. Type Inference (การเดาชนิดข้อมูลอัตโนมัติ)
let score = 100        // Swift เดาว่าเป็น Int
let title = "Champion" // Swift เดาว่าเป็น String




