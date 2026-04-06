//🎯 ทำไมต้องใช้ async/await ?
//ก่อน iOS 15 เราต้องเขียน code แบบนี้ (callback หรือ completion handler):

//URLSession.shared.dataTask(with: url) { data, response, error in
//    // ทำงานหลังโหลดเสร็จ
//}.resume()

//ข้อเสียคือ:
//โค้ดซ้อนกันหลายชั้น (callback hell)
//อ่านยาก
//ต้องจัดการ thread เอง
//แต่พอมี async/await แล้ว… 👇
//เราสามารถเขียนแบบ “ลำดับปกติ” ที่อ่านง่ายสุด ๆ

//🚀 ตัวอย่างก่อน-หลัง
//❌ แบบเก่า (callback)

//func fetchUser(completion: @escaping (User?) -> Void) {
//    guard let url = URL(string: "https://example.com/user") else { return }
//    URLSession.shared.dataTask(with: url) { data, _, _ in
//        guard let data = data else { return }
//        let user = try? JSONDecoder().decode(User.self, from: data)
//        completion(user)
//    }.resume()
//}

//✅ แบบใหม่ (async/await)
//func fetchUser() async throws -> User {
//    let url = URL(string: "https://example.com/user")!
//    let (data, _) = try await URLSession.shared.data(from: url)
//    return try JSONDecoder().decode(User.self, from: data)
//}

//🧠 ความต่างคือ “เราไม่ต้องใช้ completion handler”
//แค่ใช้ await เพื่อ “รอ” ให้คำสั่งนั้นเสร็จ แล้วไปต่อได้เลย

import UIKit

struct Post: Codable {
    let id: Int
    let title: String
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await fetchData()
        }
        
        Task {
            do {
                let post = try await fetchPost()
                print("✅", post.title)
            } catch {
                print("❌ Error:", error)
            }
        }
        
        Task {
            do {
                let data = try await fetchData(from: "https://example.com")
                print("ได้ข้อมูล:", data.count)
            } catch {
                print("❌ เกิดข้อผิดพลาด:", error)
            }
        }
        
        Task {
            let post = try await fetchPost()
            await updateUI(with: post)
        }
    }

//    🧱 ตัวอย่างพื้นฐาน
    func fetchData() async {
        print("เริ่มโหลด...")
        try? await Task.sleep(nanoseconds: 2_000_000_000) // หน่วง 2 วินาที
        print("โหลดเสร็จ ✅")
//        เริ่มโหลด...
//        (รอ 2 วินาที)
//        โหลดเสร็จ ✅
    }

    func fetchPost() async throws -> Post {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Post.self, from: data)
//        ✅ โค้ดนี้อ่านเรียงจากบนลงล่างเหมือน synchronous
//        แต่จริง ๆ มันยัง “ไม่ block thread” — UI ยังทำงานได้ตามปกติ
    }

//    ⚙️ Async Function แบบ Throw Error
//    คุณสามารถทำให้ async function “โยน error” ได้ด้วย throws
    func fetchData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }

//    🧩 ใช้ async let โหลดหลายอย่างพร้อมกัน
//    โหลดหลาย API พร้อม ๆ กัน โดยไม่ต้องรอทีละอัน
//    async let post1 = fetchPost(id: 1)
//    async let post2 = fetchPost(id: 2)
//
//    let (p1, p2) = try await (post1, post2)
//    print("✅ โหลดครบ: \(p1.title), \(p2.title)")

//    🧰 ใช้ TaskGroup รวมงาน async หลายรายการ
    //    🔥 ใช้สำหรับ “โหลดหลายรายการพร้อมกัน”
    //    เช่น โหลด 10 รูป หรือดึงข้อมูล 5 endpoint
//    func fetchAllPosts() async throws -> [Post] {
//        try await withThrowingTaskGroup(of: Post.self) { group in
//            for id in 1...5 {
//                group.addTask {
//                    try await fetchPost(id: id)
//                }
//            }
//
//            var posts: [Post] = []
//            for try await post in group {
//                posts.append(post)
//            }
//            return posts
//        }
//    }
    
//    🧭 Thread Safety: @MainActor
//    เมื่อจะอัปเดต UI หลังจาก async call เสร็จ
//    ให้ใช้ @MainActor เพื่อกลับมา main thread เช่น:
    @MainActor
    func updateUI(with post: Post) {
//        titleLabel.text = post.title
    }
}

