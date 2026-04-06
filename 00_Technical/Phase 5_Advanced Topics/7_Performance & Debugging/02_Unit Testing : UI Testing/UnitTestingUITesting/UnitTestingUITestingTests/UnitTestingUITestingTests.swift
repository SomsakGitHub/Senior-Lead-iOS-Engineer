//🧠 1. Unit Testing
//💬 คืออะไร?
//Unit Test คือการทดสอบ ฟังก์ชันหรือคลาสเล็ก ๆ (Unit) เพื่อยืนยันว่า logic ทำงานถูกต้อง
//
//🧰 สร้าง Unit Test Target
//ใน Xcode:
//File → New → Target → iOS Unit Testing Bundle → ตั้งชื่อเช่น MyAppTests
//Xcode จะสร้างโฟลเดอร์ MyAppTests
//และไฟล์เริ่มต้นชื่อ MyAppTests.swift

//✅ ตัวอย่างง่าย ๆ
//โค้ดที่เราต้องการทดสอบ:

struct Calculator {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
}

//🧩 ตัวอย่างทดสอบ Error Handling
enum NetworkError: Error {
    case invalidURL
}

class APIService {
    func fetchData(from urlString: String) throws -> String {
        guard URL(string: urlString) != nil else {
            throw NetworkError.invalidURL
        }
        return "Data"
    }
}

//class NetworkManager {
//    func fetchPost() async throws -> Post {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
//        let (data, _) = try await URLSession.shared.data(from: url)
//        return try JSONDecoder().decode(Post.self, from: data)
//    }
//}

import XCTest
@testable import UnitTestingUITesting

final class UnitTestingUITestingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddition() {
        let calc = Calculator()
        let result = calc.add(2, 3)
        XCTAssertEqual(result, 5, "ผลบวกควรเท่ากับ 5")
//        ✅ รันได้โดยกด ⌘ + U
//        หรือไปที่ Product → Test
    }
    
//    func testFetchData_InvalidURL_ThrowsError() {
//        let service = APIService()
//        XCTAssertThrowsError(try service.fetchData(from: "invalid url")) { error in
//            XCTAssertEqual(error as? NetworkError, .invalidURL)
//        }
//    }
    
//    func testFetchPost() async throws {
//        let manager = NetworkManager()
//        let post = try await manager.fetchPost()
//        XCTAssertFalse(post.title.isEmpty)
//    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
