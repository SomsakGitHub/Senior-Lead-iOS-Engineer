import UIKit

//1. Function (ฟังก์ชัน)
//คือ “กล่องโค้ด” ที่ใช้ทำงานซ้ำได้ มี input และ output ชัดเจน

//โครงสร้างพื้นฐาน
func greet(name: String) -> String {
    return "Hello, \(name)!"
}

let message = greet(name: "Somsak")
print(message)  // Hello, Somsak!

//func = คำสั่งประกาศฟังก์ชัน
//greet = ชื่อฟังก์ชัน
//(name: String) = parameter (ค่าที่รับเข้า)
//-> String = type ของค่าที่ return ออกมา

//2. Closure (โคลเชอร์)
//คือ “ฟังก์ชันแบบไม่มีชื่อ (anonymous function)”
//สามารถเก็บไว้ในตัวแปร ส่งเป็น parameter หรือ return จาก function ได้

//ตัวอย่างพื้นฐาน
let greetClosure = { (name: String) -> String in
    return "Hello, \(name)!"
}

print(greetClosure("Somsak")) // Hello, Somsak!

//จุดสังเกต:
//ไม่มีชื่อฟังก์ชัน
//ใช้ in แยกระหว่าง parameter กับ body

//การย่อแบบ Swift-style
//Swift ฉลาดมากจน closure เขียนสั้นลงได้เรื่อย ๆ เช่น
let greetClosureSwiftStyle: (String) -> String = { name in
    "Hello, \(name)!"
}

//หรือสั้นสุด ๆ แบบ inline
["Somsak", "Mew", "Ton"].map { "Hi, \($0)" }

//ใช้งานจริงบ่อยใน iOS
//เช่น callback, completion handler, animation, หรือ network request
func loadData(completion: @escaping (String) -> Void) {
    // จำลองโหลดข้อมูล
    DispatchQueue.global().async {
        completion("Data Loaded ✅")
    }
}

loadData { result in
    print(result) // Data Loaded ✅
}




