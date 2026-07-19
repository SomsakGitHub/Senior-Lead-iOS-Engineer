import UIKit

//🎯 แนวคิดหลัก: Codable
//
//ใน Swift การแปลง JSON ↔️ Object ใช้โปรโตคอลชื่อว่า

//Codable = Decodable + Encodable

//Decodable → แปลง JSON → Struct
//
//Encodable → แปลง Struct → JSON
//
//Codable → รวมทั้งสองอย่าง (ใช้บ่อยที่สุด)

//📦 ตัวอย่าง JSON
//
//สมมติคุณเรียก API แล้วได้ข้อมูลแบบนี้:

//{
//  "userId": 1,
//  "id": 101,
//  "title": "Hello Swift",
//  "body": "Learning Codable is easy!"
//}

//🧱 ขั้นตอนที่ 1: สร้าง Struct ที่ตรงกับ JSON

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

//✅ ชื่อ property ต้อง “ตรงกับ key” ใน JSON (case-sensitive)

    //🧩 ขั้นตอนที่ 2: แปลง JSON → Struct (Decode)
    func example() {
        let jsonData = """
        {
          "userId": 1,
          "id": 101,
          "title": "Hello Swift",
          "body": "Learning Codable is easy!"
        }
        """.data(using: .utf8)!

        do {
            let post = try JSONDecoder().decode(Post.self, from: jsonData)
            print(post.title) // 👉 "Hello Swift"
        } catch {
            print("❌ JSON decode error:", error)
        }
        
//        💡 ใช้ JSONDecoder().decode(YourStruct.self, from: data)
//        เพื่อแปลงข้อมูล JSON เป็น object ของ struct ที่เราสร้างไว้
    }
    
//    🧠 ขั้นตอนที่ 3: แปลง Struct → JSON (Encode)
    func example2() {
        let post = Post(userId: 1, id: 101, title: "Swift Codable", body: "Encode example")

        do {
            let data = try JSONEncoder().encode(post)
            let jsonString = String(data: data, encoding: .utf8)!
            print(jsonString)
//        {"userId":1,"id":101,"title":"Swift Codable","body":"Encode example"}
        } catch {
            print("❌ Encode error:", error)
        }
    }
    
//    🧮 JSON Array → [Struct]
//    ถ้า API ส่งข้อมูลกลับมาเป็น “อาเรย์ของหลาย object” แบบนี้:
//    [
//      { "id": 1, "title": "A" },
//      { "id": 2, "title": "B" }
//    ]
//    ให้ใช้ [Post].self ตอน decode:
    
    struct PostExample3: Codable {
        let id: Int
        let title: String
    }
//
//    do {
//        let posts = try JSONDecoder().decode([PostExample3].self, from: jsonData)
//        print(posts[0].title) // "A"
//    } catch {
//        print(error)
//    }
    
//    🎭 ถ้า key ใน JSON ไม่ตรงกับชื่อ property
//    สมมติ JSON ส่งกลับแบบนี้:
    
//    {
//      "user_id": 1,
//      "post_title": "Hello"
//    }
    
//    แต่คุณอยากใช้ชื่อ property แบบ Swift เช่น userId, title
//    ให้ใช้ CodingKeys mapping แบบนี้ 👇

    struct PostCodingKeys: Codable {
        let userId: Int
        let title: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case title = "post_title"
        }
    }
    
//    ⚡ CodingKeys จะช่วย “แม็ปชื่อใน JSON” ให้ตรงกับ property ใน struct
    
//    💥 ตัวอย่าง JSON ซ้อน (Nested JSON)
//    {
//      "id": 1,
//      "user": {
//        "name": "Alice",
//        "email": "alice@example.com"
//      }
//    }
    
    struct PostNestedJSON: Codable {
        let id: Int
        let user: User
    }

    struct User: Codable {
        let name: String
        let email: String
    }

//    ตอน decode ก็ยังเหมือนเดิม:
//
//    let post = try JSONDecoder().decode(Post.self, from: data)
//    print(post.user.name) // Alice
    
//    🧩 Optional Fields
//
//    บาง API อาจมีบาง key หายไป เช่น "body" ไม่มีในบาง object
//    ให้ใช้ ? เพื่อไม่ให้ decode ล้มเหลว:
    
    struct PostOptional: Codable {
        let id: Int
        let title: String?
    }

//    ✅ ถ้า key หาย → title จะเป็น nil แทนที่จะ crash
    
//    ⚙️ ตั้งค่า Decoder พิเศษ (เช่น snake_case → camelCase)
//    ถ้า API ใช้ key แบบ "user_id" แต่ struct เป็น userId
//    คุณไม่ต้องเขียน CodingKeys เองทุกครั้ง
//    ใช้ decoder แบบนี้แทนได้เลย:
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//    let post = try decoder.decode(Post.self, from: data)
    
//    🔄 มันจะ map อัตโนมัติจาก user_id → userId, created_at → createdAt
    
//    🧭 ตัวอย่างครบวงจร: Fetch + Parse JSON จาก API
    
    struct PostParse: Codable {
        let id: Int
        let title: String
        let body: String
    }

    func fetchPost() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let post = try JSONDecoder().decode(PostParse.self, from: data)
            print("✅ Title:", post.title)
        } catch {
            print("❌ Error:", error)
        }
    }



