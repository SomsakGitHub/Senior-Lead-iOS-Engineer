//🎯 Error Handling คืออะไร?
//
//คือการ “ตรวจจับ” และ “จัดการ” ข้อผิดพลาดที่อาจเกิดขึ้นระหว่างการทำงานของโปรแกรม
//เช่น:
//โหลดไฟล์ไม่เจอ
//API ล้มเหลว
//ข้อมูลไม่ถูกต้อง
//แปลง JSON ผิดพลาด
//แทนที่โปรแกรมจะ crash ทันที
//เราสามารถ “โยน (throw)” และ “ดักจับ (catch)” ข้อผิดพลาดได้

//    🧩 1. การประกาศ Error
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed
}
//💡 ใช้ enum จะช่วยจำแนกสาเหตุของ error ได้ชัดเจน

enum APIError: Error {
    case invalidURL
    case noData
    case decodingFailed
}

struct Post: Codable {
    let id: Int
    let title: String
}

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            do {
                let post = try await fetchPost()
                print("✅ Title:", post.title)
            } catch {
                print("❌ Error:", error)
            }
        }
        
        Task {
            do {
                let post = try await fetchPost(id: 1)
                print("✅ \(post.title)")
            } catch APIError.invalidURL {
                print("❌ URL ผิดพลาด")
            } catch APIError.decodingFailed {
                print("❌ แปลง JSON ไม่ได้")
            } catch {
                print("❌ อื่น ๆ:", error)
            }
        }
    }

//    ⚙️ 2. การ “โยน” Error (Throw)
//    เมื่อเกิดปัญหาในฟังก์ชัน เราสามารถ “โยน” error ได้ด้วย throw
    func fetchData(from urlString: String) throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        return try Data(contentsOf: url)
    }
//    ฟังก์ชันที่อาจเกิด error ต้องใส่คำว่า throws หลังพารามิเตอร์
//    เพื่อบอกว่าผู้เรียกต้อง “จัดการ error เอง”

//    🧠 3. การ “เรียก” ฟังก์ชันที่โยน Error (Try)
//    เมื่อเราเรียกฟังก์ชัน throws
//    เราต้องใส่คำว่า try หน้าคำสั่งนั้น เช่น:
    func performDataFetch() {
        do {
            let data = try fetchData(from: "https://example.com")
            print("✅ ได้ข้อมูลขนาด \(data.count)")
        } catch {
            print("❌ Error:", error)
        }
    }
//    do { ... } catch { ... } จะใช้จับ error ที่โยนออกมา

//    🧱 4. หลายกรณีของ Error (Catch แบบเฉพาะ)
    func performDataFetchWithMultipleErrorCases() {
        do {
            let data = try fetchData(from: "bad_url")
        } catch NetworkError.invalidURL {
            print("❌ URL ไม่ถูกต้อง")
        } catch NetworkError.noData {
            print("❌ ไม่มีข้อมูล")
        } catch {
            print("❌ ข้อผิดพลาดอื่น ๆ:", error)
        }
    }
//    ✅ สามารถแยก catch แต่ละกรณีได้เพื่อจัดการต่างกัน
    
//    🔧 5. try? และ try!
//    Swift มี shorthand สำหรับจัดการ error แบบง่าย ๆ
//    🔹 try? → แปลง error เป็น nil
//    let data = try? fetchData(from: "https://example.com")
//    print(data ?? "ไม่มีข้อมูล")
//    ถ้าเกิด error จะไม่ crash แต่จะได้ nil แทน
    
//    🔹 try! → บังคับให้ต้องสำเร็จ
//    let data = try! fetchData(from: "https://example.com")
//    ถ้าเกิด error → 💥 crash ทันที
//    ควรใช้เฉพาะกรณีที่มั่นใจ 100% ว่าไม่ fail

//    ⚙️ 6. การใช้กับ Async/Await
//    Error handling ทำงานได้เหมือนเดิมกับ async function
//    แค่เพิ่มคำว่า await เข้าไป:
    
    func fetchPost() async throws -> Post {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Post.self, from: data)
    }
//    ✅ ใช้ try await เพื่อรอผลลัพธ์และดัก error พร้อมกัน
    
//    🧰 7. ฟังก์ชันที่ไม่โยน Error
//    ฟังก์ชันที่ไม่โยน error → ไม่ต้องใช้ try
//    แต่ถ้ามีการเรียกฟังก์ชัน throws ข้างใน → ต้องใช้ try เสมอ

    func safeFetch() {
        do {
            let data = try fetchData(from: "https://example.com")
            print("โหลดข้อมูลสำเร็จ")
        } catch {
            print("โหลดข้อมูลล้มเหลว:", error)
        }
    }

//    🧩 8. ฟังก์ชันที่ “ส่งต่อ Error”
    func loadData() throws -> Data {
        try fetchData(from: "https://example.com")
    }
//    เมื่อใส่ throws ฟังก์ชันนี้จะ “ส่งต่อ error ที่เกิดข้างใน”
    
//    🎨 9. ตัวอย่างรวม (Network + Decode)
    


    func fetchPost(id: Int) async throws -> Post {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)") else {
            throw APIError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode(Post.self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }




}

