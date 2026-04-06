import Foundation

struct Post: Sendable {
    let id: Int
    let title: String
    let body: String
}
nonisolated extension Post: Decodable {}
