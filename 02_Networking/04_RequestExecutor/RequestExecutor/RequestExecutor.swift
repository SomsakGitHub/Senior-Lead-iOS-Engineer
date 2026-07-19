import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, data: Data?)
    case decodingError(Error)
    case encodingError(Error)
    case noData
    case timeout
    case connectionLost
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode, _):
            return "HTTP error \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Encoding error: \(error.localizedDescription)"
        case .noData:
            return "No data received"
        case .timeout:
            return "Request timed out"
        case .connectionLost:
            return "Connection lost"
        case .unknown(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Request {
    associatedtype Response: Decodable
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem] { get }
}

extension Request {
    var headers: [String: String] { [:] }
    var body: Data? { nil }
    var queryItems: [URLQueryItem] { [] }
}

protocol RequestExecutor {
    func execute<T: Request>(_ request: T) async throws -> T.Response
    func executeRaw(_ request: any Request) async throws -> (Data, HTTPURLResponse)
}

actor URLSessionRequestExecutor: RequestExecutor {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }

    func execute<T: Request>(_ request: T) async throws -> T.Response {
        let (data, response) = try await executeRaw(request)

        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.httpError(statusCode: response.statusCode, data: data)
        }

        do {
            return try decoder.decode(T.Response.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    func executeRaw(_ request: any Request) async throws -> (Data, HTTPURLResponse) {
        guard var urlComponents = URLComponents(string: request.url) else {
            throw NetworkError.invalidURL
        }

        if !request.queryItems.isEmpty {
            urlComponents.queryItems = request.queryItems
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body

        for (key, value) in request.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        if request.body != nil && urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch let error as URLError where error.code == .timedOut {
            throw NetworkError.timeout
        } catch let error as URLError where error.code == .cannotFindHost || error.code == .cannotConnectToHost || error.code == .networkConnectionLost {
            throw NetworkError.connectionLost
        } catch {
            throw NetworkError.unknown(error)
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        return (data, httpResponse)
    }
}
