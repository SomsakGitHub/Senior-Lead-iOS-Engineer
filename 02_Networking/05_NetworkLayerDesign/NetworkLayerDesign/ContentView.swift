import SwiftUI

// MARK: - Example API Endpoints

enum PostEndpoint: APIEndpoint {
    case list
    case detail(id: Int)

    var path: String {
        switch self {
        case .list:
            return "/posts"
        case .detail(let id):
            return "/posts/\(id)"
        }
    }

    var method: HTTPMethod {
        .get
    }
}

// MARK: - Example Response Model

struct Post: Codable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

// MARK: - Content View

struct ContentView: View {
    @State private var posts: [Post] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let networkService = NetworkService(
        config: NetworkConfig(
            baseURL: URL(string: "https://jsonplaceholder.typicode.com")!
        )
    )

    var body: some View {
        NavigationSplitView {
            List {
                if isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage {
                    ContentUnavailableView {
                        Label("Error", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(errorMessage)
                    } actions: {
                        Button("Retry") {
                            Task { await fetchPosts() }
                        }
                    }
                } else {
                    ForEach(posts) { post in
                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(post.title)
                                    .font(.headline)
                                Text("User \(post.userId)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        Task { await fetchPosts() }
                    } label: {
                        Label("Refresh", systemImage: "arrow.clockwise")
                    }
                }
            }
        } detail: {
            Text("Select a post")
        }
        .task {
            await fetchPosts()
        }
    }

    private func fetchPosts() async {
        isLoading = true
        errorMessage = nil

        do {
            posts = try await networkService.request(PostEndpoint.list)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}

// MARK: - Post Detail View

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title)
                    .font(.title2)
                    .fontWeight(.bold)

                Text("By User \(post.userId)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Divider()

                Text(post.body)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Post \(post.id)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
