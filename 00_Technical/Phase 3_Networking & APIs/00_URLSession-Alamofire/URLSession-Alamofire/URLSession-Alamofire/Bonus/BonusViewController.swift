//⚡ Bonus: URLSession + async/await (iOS 15+)
//
//เขียนโค้ดแบบ synchronous ที่อ่านง่ายมาก

import UIKit

class BonusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task {
            await fetchPost()
        }
    }
    
    func fetchPost() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let post = try JSONDecoder().decode(Post.self, from: data)
            print("✅ Title:", post.title)
        } catch {
            print("❌ Error:", error)
        }
    }
}
