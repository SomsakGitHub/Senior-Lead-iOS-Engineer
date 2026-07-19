import Foundation

protocol APIEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }

    func urlRequest(config: NetworkConfig) throws -> URLRequest {
        var components = URLComponents(
            url: config.baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: true
        )

        if let queryItems {
            components?.queryItems = queryItems
        }

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: config.timeoutInterval
        )
        request.httpMethod = method.rawValue
        request.httpBody = body

        for (key, value) in config.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        for (key, value) in headers ?? [:] {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
