import Foundation

struct NetworkConfig {
    let baseURL: URL
    let headers: [String: String]
    let timeoutInterval: TimeInterval

    init(
        baseURL: URL,
        headers: [String: String] = [:],
        timeoutInterval: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.headers = headers
        self.timeoutInterval = timeoutInterval
    }

    static let `default` = NetworkConfig(
        baseURL: URL(string: "https://api.example.com")!,
        headers: [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    )
}
