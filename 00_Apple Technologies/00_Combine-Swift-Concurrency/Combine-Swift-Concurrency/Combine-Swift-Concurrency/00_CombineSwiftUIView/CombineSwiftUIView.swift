//🔹 Combine กับ SwiftUI
//
//SwiftUI ทำงานร่วมกับ Combine โดยตรง
//(@Published → เชื่อมกับ @ObservedObject, @StateObject)

import SwiftUI
import Combine

struct CombineSwiftUIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CombineSwiftUIView()
}

class PostViewModel: ObservableObject {
    @Published var post: Post?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPost() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Post.self, decoder: JSONDecoder())
            .replaceError(with: Post(id: 0, title: "Error"))
            .receive(on: RunLoop.main)
            .map(Optional.some)
            .sink { [weak self] value in
                self?.post = value
            }
            .store(in: &cancellables)
    }
}

