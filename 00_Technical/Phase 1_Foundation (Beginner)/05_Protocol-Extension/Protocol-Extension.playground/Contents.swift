import UIKit

//1. Protocol คืออะไร?
//Protocol = “สัญญา” หรือ “แบบฟอร์ม” ที่กำหนดว่า
//ถ้าใครอยาก conform (ทำตาม) ต้องมี property / method อะไรบ้าง
//คล้าย “interface” ในภาษาอื่น (เช่น Java, C#)

protocol Greetable {
    var name: String { get }
    func greet()
}

//ใคร conform โปรโตคอลนี้ ต้องมี name และ greet() แน่ ๆ
//การใช้งาน
struct Person: Greetable {
    var name: String

    func greet() {
        print("Hello, my name is \(name)")
    }
}

let p = Person(name: "Somsak")
p.greet() // Hello, my name is Somsak
//✅ Person ทำตามสัญญา (มี name และ greet())

//🧱 2. Protocol Property และ Method Requirements
//Property
//ระบุได้ว่าจะเป็น “อ่านอย่างเดียว” (get) หรือ “อ่าน/เขียนได้” (get set)

protocol Vehicle {
    var speed: Int { get set }
    func move()
}

//Method
//เหมือน function ทั่วไป แต่ไม่มี body

protocol Flyable {
    func fly()
}

//⚙️ 3. Protocol Inheritance
//โปรโตคอลสามารถ “สืบทอด” จากโปรโตคอลอื่นได้ด้วย

protocol Animal {
    func eat()
}

protocol Pet: Animal {
    func play()
}

//💡 4. ใช้ Protocol เพื่อทำ Polymorphism (แทน Class Hierarchy)
protocol Drawable {
    func draw()
}

struct Circle: Drawable {
    func draw() { print("Drawing circle") }
}

struct Square: Drawable {
    func draw() { print("Drawing square") }
}

func render(_ shape: Drawable) {
    shape.draw()
}

render(Circle()) // Drawing circle
render(Square()) // Drawing square
//✅ เหมือนการใช้ Interface — แต่ปลอดภัยและเบากว่าใน Swift

//5. Extension คืออะไร?
//Extension = “ขยายความสามารถของ type เดิม”
//โดยไม่ต้องแก้ไขโค้ดต้นฉบับ
//ใช้ได้กับ Struct, Class, Enum, หรือ Protocol เองด้วย

extension String {
    func reversedText() -> String {
        return String(self.reversed())
    }
}

print("Hello".reversedText()) // "olleH"
//✅ เพิ่ม method ใหม่ใน String ได้เลย โดยไม่แตะโค้ดเดิมของ Apple

//ขยาย Struct ของเราเอง
struct User {
    let name: String
}

extension User {
    func greet() {
        print("Hi, \(name)!")
    }
}

let user = User(name: "Somsak")
user.greet() // Hi, Somsak!

//6. Extension + Protocol = Powerful Combo ⚡
//ใช้คู่กันบ่อยมากใน iOS เพราะมันทำให้ code แยกส่วน / reusable

protocol Identifiable {
    var id: String { get }
}

extension Identifiable {
    func identify() {
        print("My ID is \(id)")
    }
}

struct User0: Identifiable {
    let id: String
}

let u = User0(id: "1234")
u.identify() // My ID is 1234
//✅ ถ้า type ใด conform Identifiable → ได้ method identify() ฟรีเลย

//7. Protocol + Extension ใน UIKit / SwiftUI
//UIKit ตัวอย่าง:
protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String { String(describing: Self.self) }
}

class MyTableViewCell: UITableViewCell, ReusableCell {}
print(MyTableViewCell.identifier) // "MyTableViewCell"

//SwiftUI ตัวอย่าง:
protocol ThemedView {
    var backgroundColor: String { get }
}

extension ThemedView {
    var backgroundColor: String { "Blue" }
}

struct HomeView: ThemedView {}
print(HomeView().backgroundColor) // Blue






