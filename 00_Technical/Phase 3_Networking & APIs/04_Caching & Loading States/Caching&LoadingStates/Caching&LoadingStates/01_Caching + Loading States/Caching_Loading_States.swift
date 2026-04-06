import SwiftUI
import Combine

struct Caching_Loading_States: View {
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        NavigationStack {
//            💡 Group ใช้แสดง “หลายสถานะในที่เดียว”
//            เช่น กำลังโหลด → แสดงวงกลม,
//            error → แสดงข้อความ,
//            สำเร็จ → แสดง List
            Group {
                if viewModel.isLoading {
                    ProgressView("กำลังโหลด...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("❌ \(error)")
                        Button("ลองอีกครั้ง") {
                            Task { await viewModel.fetchPosts() }
                        }
                    }
                } else {
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading) {
                            Text(post.title).font(.headline)
                            Text(post.body).font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
        }
        .task {
            await viewModel.fetchPosts()
        }
    }
}

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cache: [Post] = [] // simple in-memory cache
    
    func fetchPosts() async {
        // ถ้ามี cache แล้ว → ใช้ก่อนเลย
        if !cache.isEmpty {
            posts = cache
            print("🗂 โหลดจาก Cache")
            return
        }
        
        // เริ่มโหลด
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false } // ทำเสมอเมื่อจบ
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode([Post].self, from: data)
            posts = decoded
            cache = decoded // เก็บลง cache
            print("✅ โหลดจาก Network")
        } catch {
            errorMessage = "โหลดข้อมูลไม่สำเร็จ: \(error.localizedDescription)"
        }
        
//        ⚙️ เพิ่ม Cache ที่ “เก็บถาวร” (Disk Cache)
//        ถ้าอยากให้ cache อยู่แม้ปิดแอปไปแล้ว
//        ใช้ FileManager หรือ UserDefaults ก็ได้
        
        func saveCache(_ posts: [Post]) {
            if let data = try? JSONEncoder().encode(posts) {
                UserDefaults.standard.set(data, forKey: "cachedPosts")
            }
        }

        func loadCache() -> [Post]? {
            if let data = UserDefaults.standard.data(forKey: "cachedPosts"),
               let posts = try? JSONDecoder().decode([Post].self, from: data) {
                return posts
            }
            return nil
        }
        
//        ✅ แล้วเรียก loadCache() ก่อนยิง API
//        และเรียก saveCache() หลังโหลดสำเร็จ

    }
}

#Preview {
    Caching_Loading_States()
}
