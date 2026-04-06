import UIKit

//🧩 1. Generics (เจนเนอริกส์)
//💡 Generics คือ “ฟังก์ชันหรือ type ที่เขียนครั้งเดียว ใช้ได้กับหลายชนิดข้อมูล”
//ช่วยให้โค้ด “ยืดหยุ่น ปลอดภัย และไม่ซ้ำซ้อน”

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

//<T> = ตัวแทนชนิดข้อมูล (type placeholder)
//Swift จะรู้เองว่า T คือ type อะไรตอนเรียกใช้

var x = 10
var y = 20
swapValues(&x, &y)
print(x, y) // 20 10

var a = "Somsak"
var b = "Mew"
swapValues(&a, &b)
print(a, b) // Mew Somsak
//✅ เขียนโค้ดครั้งเดียว ใช้ได้ทั้งกับ Int และ String

//🧱 Generic Type (ใช้ใน Struct / Class)
struct Stack<Element> {
    private var items: [Element] = []
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element? {
        return items.popLast()
    }
}
//ใช้ได้กับทุกชนิดข้อมูล 👇
var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
print(intStack.pop()!) // 20

var stringStack = Stack<String>()
stringStack.push("A")
stringStack.push("B")
print(stringStack.pop()!) // B

//⚙️ Generic Constraints (จำกัดชนิดข้อมูล)
//ถ้าอยากให้ใช้ได้เฉพาะบางชนิด เช่นเฉพาะที่เป็น Comparable หรือ Hashable

func findMax<T: Comparable>(_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

print(findMax(3, 7))       // 7
print(findMax("A", "Z"))   // Z

//⚡ 2. Enum (เอนัม)
//💡 Enum คือ “ชุดของค่าที่เป็นไปได้ทั้งหมด” ของข้อมูลบางประเภท
//ใช้แทนค่าที่แน่นอน เช่น “สถานะ”, “ประเภท”, “โหมด”

enum Direction {
    case north
    case south
    case east
    case west
}

var dir = Direction.north
dir = .south // ไม่ต้องพิมพ์ชื่อ enum ซ้ำ

//🧱 ใช้กับ switch (ยอดนิยมมาก)
switch dir {
case .north:
    print("Go up")
case .south:
    print("Go down")
case .east:
    print("Go right")
case .west:
    print("Go left")
}

//🧩 Enum พร้อมค่ากำกับ (Associated Values)
//ใช้เก็บข้อมูลเพิ่มเติมในแต่ละกรณี

enum NetworkResponse {
    case success(data: String)
    case failure(error: String)
}

let response = NetworkResponse.success(data: "OK!")

switch response {
case .success(let data):
    print("Data:", data)
case .failure(let error):
    print("Error:", error)
}

//🧮 Enum พร้อม Raw Value (เชื่อมกับค่าเดิม เช่น String / Int)
enum Day: String {
    case monday = "Mon"
    case tuesday = "Tue"
    case wednesday = "Wed"
}

print(Day.monday.rawValue) // Mon

//⚙️ Enum แบบมีฟังก์ชันในตัว
enum TrafficLight {
    case red, yellow, green
    
    func action() -> String {
        switch self {
        case .red: return "Stop"
        case .yellow: return "Wait"
        case .green: return "Go"
        }
    }
}

print(TrafficLight.green.action()) // Go

//🧠 Generics + Enum = คู่เทพของ Swift
//ตัวอย่างสุดคลาสสิก: Result<T, Error>

enum Result<T> {
    case success(T)
    case failure(Error)
}

//หรือ Optional<T> เองก็เป็น enum!

enum Optional<Wrapped> {
    case some(Wrapped)
    case none
}

//🔥 Swift ใช้ Generics + Enum เพื่อสร้างระบบ type-safe ที่สุดยอดมาก









