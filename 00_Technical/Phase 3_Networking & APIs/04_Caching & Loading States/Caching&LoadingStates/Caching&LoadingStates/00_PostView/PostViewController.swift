import UIKit

class PostViewController: UIViewController {
    private var posts: [Post] = []
    private var activity = UIActivityIndicatorView(style: .large)
//    ใช้ UIActivityIndicatorView แสดงสถานะกำลังโหลด
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .systemBackground
        activity.center = view.center
        view.addSubview(activity)
        
        Task { await fetchPosts() }
    }
    
    func fetchPosts() async {
        activity.startAnimating()
        defer { activity.stopAnimating() }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let posts = try JSONDecoder().decode([Post].self, from: data)
            self.posts = posts
            print("✅ โหลดสำเร็จ:", posts.count)
        } catch {
            print("❌ Error:", error)
        }
    }
}
