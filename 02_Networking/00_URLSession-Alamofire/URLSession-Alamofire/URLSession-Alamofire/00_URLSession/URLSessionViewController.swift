//    🌐 1. URLSession (พื้นฐาน Networking ของ iOS)
//
//    เป็น class มาตรฐานของ Apple สำหรับทำงานกับ HTTP เช่น GET / POST
//    ใช้ได้ในทุกโปรเจกต์โดยไม่ต้องติดตั้ง library เพิ่ม

import UIKit

class URLSessionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error: \(error)")
                return
            }
            guard let data = data else { return }
            
            Task { @MainActor in
                do {
                    let post = try JSONDecoder().decode(Post.self, from: data)
                    print("✅ Title:", post.title)
                } catch {
                    print("❌ JSON decode failed:", error)
                }
            }
        }
        task.resume()
//        💡 ใช้ JSONDecoder() แปลง JSON → Struct (ที่ conform Codable)
//        ทำงานแบบ asynchronous ต้องใช้ task.resume() เพื่อเริ่มโหลด
    }
    
//    🧱 ตัวอย่าง POST (ส่งข้อมูลไป server)
    func createPost() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
//        ✅ ใช้ URLRequest กำหนด method, headers และ body ได้เอง
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let newPost = ["title": "Hello", "body": "Swift Networking"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: newPost)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
            }
        }.resume()
    }

}

