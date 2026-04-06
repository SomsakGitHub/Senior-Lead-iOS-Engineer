import SwiftUI
import Combine

//SwiftUI + MVVM เป็นคู่ที่สมบูรณ์แบบ 🔥

@MainActor
class PostViewModelSwiftUi: ObservableObject {
    @Published var post: Post?
    
    func fetchPost() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            post = try JSONDecoder().decode(Post.self, from: data)
        } catch {
            print("Error:", error)
        }
    }
}

struct swiftUiMVVMView: View {
    @StateObject var vm = PostViewModelSwiftUi()
    
    var body: some View {
        VStack {
            if let post = vm.post {
                Text(post.title).font(.headline)
            } else {
                ProgressView("Loading...")
            }
        }
        .task {
            await vm.fetchPost()
        }
    }
}

#Preview {
    swiftUiMVVMView()
}


