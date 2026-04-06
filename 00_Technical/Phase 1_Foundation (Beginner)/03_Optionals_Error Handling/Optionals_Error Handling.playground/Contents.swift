import UIKit

//1. Optionals คืออะไร?
//ใน Swift ค่าตัวแปร “อาจจะมีค่า หรือไม่มีค่า” (nil) ได้
//แต่ปกติ Swift ไม่อนุญาตให้มีค่า nil เพื่อป้องกันการ crash
//ดังนั้น Swift จึงมี Optional type
//🔹 คือ Type ที่ “อาจจะมีค่า หรือไม่มีค่า (nil)” ได้

//การประกาศ Optional
var name: String? = "Somsak"
print(name) // Optional("Somsak")
//หรือ
var nickname: String? = nil
//String? หมายถึง “อาจจะเป็น String หรือ nil ก็ได้”

//⚠️ การดึงค่าออกจาก Optional (Unwrapping)
//เพราะค่าข้างใน “อาจเป็น nil”
//เราต้อง “unwrap” ก่อนใช้ ไม่งั้นจะ error

//Forced Unwrapping (บังคับดึงค่า) ❌ ใช้อย่างระวัง!
let name0: String? = "Mew"
print(name0!) // ใช้ ! เพื่อดึงค่า -> "Mew"
//ถ้า name เป็น nil → แอป crash ทันที ❗

//Optional Binding (แบบปลอดภัย ✅)
var nickname0: String? = "Sak"

if let n = nickname0 {
    print("Nickname is \(n)")
} else {
    print("No nickname")
}
//ถ้าไม่เป็น nil → จะเข้า if และดึงค่าออกมาในตัวแปร n

//Guard Let (ใช้ในฟังก์ชัน / ป้องกัน early exit)
func greet(name: String?) {
    guard let n = name else {
        print("No name provided")
        return
    }
    print("Hello, \(n)")
}

greet(name: nil) // No name provided
greet(name: "Somsak") // Hello, Somsak

//Nil-Coalescing Operator (??)
//ใช้กำหนดค่า default กรณีที่เป็น nil
let username: String? = nil
print(username ?? "Guest") // Output: Guest

//2. Error Handling (การจัดการข้อผิดพลาด)
//Swift ใช้ระบบ “โยนและจับข้อผิดพลาด” (throw / catch)
//เพื่อให้โค้ดปลอดภัยและไม่ crash ทันที

//✅ ขั้นตอนหลัก
//สร้าง enum Error ของคุณเอง
//ใช้ throw เพื่อโยนข้อผิดพลาด
//ใช้ do { try ... } catch { ... } เพื่อจัดการ
enum NetworkError: Error {
    case noConnection
    case invalidResponse
    case timeout
}

func fetchData(from url: String) throws -> String {
    if url.isEmpty {
        throw NetworkError.invalidResponse
    }
    return "Data from \(url)"
}

//การเรียกใช้งานด้วย do-try-catch
do {
    let data = try fetchData(from: "https://example.com")
    print(data)
} catch NetworkError.noConnection {
    print("No internet connection.")
} catch NetworkError.invalidResponse {
    print("Bad response from server.")
} catch {
    print("Unknown error: \(error)")
}

//ถ้าแน่ใจว่าจะไม่ error → ใช้ try!
//❗ ระวัง crash ถ้า error เกิดขึ้นจริง

let data = try! fetchData(from: "https://example.com")

//ถ้าอยากให้ error กลายเป็น optional → ใช้ try?
let result = try? fetchData(from: "")
print(result ?? "No data") // Output: No data








