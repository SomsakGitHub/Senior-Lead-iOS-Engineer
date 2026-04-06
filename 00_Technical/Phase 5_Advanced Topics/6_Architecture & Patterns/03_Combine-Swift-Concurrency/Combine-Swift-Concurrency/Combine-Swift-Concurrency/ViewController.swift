//🧩 PART 1: Combine Framework
//🧭 แนวคิดหลักของ Combine
//Combine ใช้แนวคิด 3 ส่วนหลัก:

//Publisher → Operator → Subscriber
//ส่วน    หน้าที่
//Publisher    แหล่งที่ส่งค่าหรือเหตุการณ์ (เช่น network, timer, user input)
//Subscriber    ตัวรับค่าที่ส่งมา
//Operator    ตัวกลางที่เปลี่ยนแปลงข้อมูลระหว่างทาง (map, filter, debounce ฯลฯ)

import Combine
import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CombineSwiftUI(_ sender: Any) {
        let combineSwiftUIView = CombineSwiftUIView()
        let hostVC = UIHostingController(rootView: combineSwiftUIView)
        present(hostVC, animated: true, completion: nil)
    }

    //🔹 ตัวอย่าง Combine แบบพื้นฐาน
    func example() {
        let publisher = [1, 2, 3, 4, 5].publisher

        let subscriber = publisher
            .map { $0 * 2 }
            .filter { $0 > 5 }
            .sink { value in
                print("📦 Received:", value)
            }
//    ผลลัพธ์:
//    📦 Received: 6
//    📦 Received: 8
//    📦 Received: 10
    }
    
    //🔹 Combine + Networking
    func fetchData() {
        let service = APIService()
        var cancellables = Set<AnyCancellable>()

        service.fetchPost()
            .sink(receiveCompletion: { print("✅ Done:", $0) },
                  receiveValue: { print("📰 Title:", $0.title) })
            .store(in: &cancellables)
    }
}

//    🔹 Combine + ViewModel (เชื่อมกับ UI)
//    ตัวอย่าง: สังเกตค่าจาก ViewModel → update UI ทันที
class CounterViewModel {
    @Published var count = 0
}

//🟢 ทุกครั้งที่ count เปลี่ยน → UI update ทันทีโดยอัตโนมัติ
class CounterViewController: UIViewController {
    let viewModel = CounterViewModel()
    var cancellables = Set<AnyCancellable>()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        label.frame = view.bounds
        
        // Binding
        viewModel.$count
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.label.text = "🔢 Count: \(value)"
            }
            .store(in: &cancellables)
        
        // Update every 1 second
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in self.viewModel.count += 1 }
            .store(in: &cancellables)
    }
}

struct Post: Codable {
    let id: Int
    let title: String
}

class APIService {
    func fetchPost() -> AnyPublisher<Post, Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Post.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}




