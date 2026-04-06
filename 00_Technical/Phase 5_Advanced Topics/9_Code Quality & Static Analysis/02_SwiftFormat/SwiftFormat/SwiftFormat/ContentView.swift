import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct Test {
    let name: String
    func run() {
        print(name)
    }
}

func fetchData(id: Int, completion: @escaping (String) -> Void) {
    guard let url = URL(string: "https://api.com/data") else {
        completion("error")
        return
    }
}
