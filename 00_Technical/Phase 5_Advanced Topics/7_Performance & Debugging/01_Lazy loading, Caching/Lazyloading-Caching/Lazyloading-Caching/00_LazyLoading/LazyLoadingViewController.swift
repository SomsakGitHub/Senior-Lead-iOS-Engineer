//🧠 1. Lazy Loading คืออะไร?
//คือเทคนิค “โหลดข้อมูลเมื่อจำเป็นเท่านั้น”
//เช่น TableView / CollectionView จะแสดงเฉพาะ cell ที่อยู่บนหน้าจอ
//Cell อื่น ๆ จะยังไม่โหลด (หรือเลื่อนถึงค่อยโหลด)

//📍 TableView จะสร้าง cell เฉพาะที่มองเห็น — เมื่อ scroll ถึงจึงโหลดข้อมูล cell ใหม่
//= นี่แหละ Lazy Loading โดยธรรมชาติของ UITableView

import UIKit

struct Post: Decodable {
    let userId, id: Int
    let title, body: String
}

class PostTableViewController: UITableViewController {
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }

    func fetchPosts() {
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(
                    from: URL(string: "https://jsonplaceholder.typicode.com/posts")!
                )
                posts = try JSONDecoder().decode([Post].self, from: data)
                tableView.reloadData()
            } catch {
                print("❌ Error:", error)
            }
        }
    }
    
    //⚡ Lazy Loading รูปภาพ (UIImageView)
    //โหลดภาพเฉพาะเมื่อ scroll ถึง cell:
//    ➡️ แต่ข้อเสีย: โหลดซ้ำทุกครั้ง → ต้องมี Cache เพื่อเก็บภาพไว้
    func loadImage(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
    }

    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let post = posts[indexPath.row]
        cell.textLabel?.text = post.title
        return cell
    }
}
