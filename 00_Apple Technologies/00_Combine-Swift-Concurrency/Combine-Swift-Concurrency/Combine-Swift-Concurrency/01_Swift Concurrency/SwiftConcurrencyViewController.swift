//⚙️ ทำไมต้องมี Concurrency?
//ก่อนหน้านี้ต้องใช้ callback หรือ Combine → ซับซ้อน
//ตอนนี้ใช้ async/await แทนได้เลย (อ่านง่ายกว่าเยอะ)

import UIKit
import Combine

class SwiftConcurrencyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await fetchData()
        }
        
        Task {
            do {
                let post = try await fetchPost()
                print("📰 Title:", post.title)
            } catch {
                print("❌ Error:", error)
            }
        }
        
        Task {
            do {
//                let post = try await fetchPostPublisher().value
//                print("✅", post.title)
            } catch {
                print("❌", error)
            }
        }
    }
    
    func fetchData() async {
        print("⏳ Loading...")
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        print("✅ Done!")
    }
    
//    🔹 async/await + URLSession
//    ✅ อ่านง่ายเหมือน synchronous code
//    ✅ ไม่มี callback hell
//    ✅ รองรับ structured concurrency
    func fetchPost() async throws -> PostConcurrency {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PostConcurrency.self, from: data)
    }
    
//    🔹 ใช้ร่วมกับ Task และ TaskGroup
//    func fetchMultiple() async {
//        async let post1 = fetchPost(id: 1)
//        async let post2 = fetchPost(id: 2)
//        let results = await [try? post1, try? post2]
//        print(results.compactMap { $0?.title })
//    }

//    🔹 Combine → async/await Bridge
//    คุณสามารถใช้ Combine กับ async/await ร่วมกันได้ เช่น:
//    func fetchPostPublisher() -> AnyPublisher<Post, Error> { ... }
}

struct PostConcurrency: Codable { let id: Int; let title: String }
