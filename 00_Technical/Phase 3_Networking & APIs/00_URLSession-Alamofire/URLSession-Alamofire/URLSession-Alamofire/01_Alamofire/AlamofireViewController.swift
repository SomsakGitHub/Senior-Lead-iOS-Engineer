//🚀 2. Alamofire (Framework ช่วยทำ Networking)
//
//💡 เป็น library ยอดนิยมที่ทำให้ URLSession ใช้ง่ายขึ้น
//จัดการ JSON, Header, Upload/Download และ Error ให้อัตโนมัติ

import UIKit
import Alamofire

// Model for decoding the created post response from jsonplaceholder
struct CreatedPost: Sendable {
    let id: Int?
    let title: String
    let body: String
}
nonisolated extension CreatedPost: Decodable {}

// Model for decoding a simple user response
struct User: Sendable {
    let id: Int
    let name: String
    let username: String?
    let email: String?
}
nonisolated extension User: Decodable {}

class AlamofireViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testAlamofire()
    }
    
    func testAlamofire() {
        AF.request("https://jsonplaceholder.typicode.com/posts/1")
            .responseDecodable(of: Post.self) { response in
                switch response.result {
                case .success(let post):
                    DispatchQueue.main.async {
                        print("✅ Title:", post.title)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("❌ Error:", error)
                    }
                }
            }
    }
    
    func testAlamofirePost() {
        let parameters: [String: Any] = [
            "title": "Hello Alamofire",
            "body": "Easy Networking!"
        ]

        AF.request(
            "https://jsonplaceholder.typicode.com/posts",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default
        ).responseDecodable(of: CreatedPost.self) { response in
            switch response.result {
            case .success(let createdPost):
                print("✅ Created Post -> id: \(String(describing: createdPost.id)), title: \(createdPost.title)")
            case .failure(let error):
                print("❌ Error:", error)
            }
        }
    }
    
    func testAlamofireHeaders() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer YOUR_TOKEN",
            "Accept": "application/json"
        ]

        AF.request("https://jsonplaceholder.typicode.com/users/1", headers: headers)
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let user):
                    print("✅ User -> id: \(user.id), name: \(user.name)")
                case .failure(let error):
                    print("❌ Error:", error)
                }
            }
    }
}

