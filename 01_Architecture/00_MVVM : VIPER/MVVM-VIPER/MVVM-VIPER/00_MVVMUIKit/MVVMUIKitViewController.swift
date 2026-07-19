//🧠 สถาปัตยกรรมคืออะไร?
//คือ “แนวทางในการแยกความรับผิดชอบของโค้ด”
//ให้แต่ละส่วนทำหน้าที่ชัดเจน → ลดการซ้ำซ้อน และเพิ่มความทดสอบได้ (testability)
//ตัวอย่างปัญหาถ้าไม่ใช้ architecture:
//ViewController มี logic เยอะเกินไป (“Massive View Controller”)
//ยากต่อการ debug หรือ reuse code
//test unit ยาก

//🧩 MVVM (Model - View - ViewModel)

//🧱 โครงสร้าง
//Model        → โครงสร้างข้อมูล / ธุรกิจ (data logic)
//View         → UI เช่น ViewController หรือ SwiftUI View
//ViewModel    → ตัวกลางระหว่าง View กับ Model

//✅ จุดเด่นของ MVVM
//Logic แยกออกจาก View → Controller เบา
//เขียน Unit Test ได้ง่าย
//ใช้ได้ดีกับ SwiftUI (เพราะ View reactive อยู่แล้ว)
//
//⚠️ ข้อเสีย
//ต้องจัดโครงสร้างดี ๆ ไม่งั้น ViewModel จะใหญ่เกินไป
//มี learning curve สำหรับ Combine / Reactive pattern

import UIKit
import Combine
import SwiftUI

//🧩 ตัวอย่าง MVVM (UIKit)
//🔸 Model.swift
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}

//🔸 ViewModel.swift
class PostViewModel {
    @Published var post: Post?
    @Published var isLoading = false

    func fetchPost() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Post.self, from: data)
            await MainActor.run {
                self.post = result
                self.isLoading = false
            }
        } catch {
            print("❌ Error:", error)
            isLoading = false
        }
    }
}


class MVVMUIKitViewController: UIViewController {
    
    let viewModel = PostViewModel()
    var cancellables = Set<AnyCancellable>()
    
    let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        bindViewModel()
        Task { await viewModel.fetchPost() }
    }
    
    func setupUI() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.$post
            .receive(on: RunLoop.main)
            .sink { [weak self] post in
                self?.titleLabel.text = post?.title
            }
            .store(in: &cancellables)
    }
}


