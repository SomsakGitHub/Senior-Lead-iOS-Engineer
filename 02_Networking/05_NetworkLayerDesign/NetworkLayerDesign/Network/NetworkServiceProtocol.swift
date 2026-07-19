import Foundation

protocol NetworkServiceProtocol: Sendable {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
    func requestRaw(_ endpoint: APIEndpoint) async throws -> (Data, HTTPURLResponse)
}

actor NetworkService: NetworkServiceProtocol {
    private let config: NetworkConfig
    private let session: URLSession

    init(
        config: NetworkConfig = .default,
        session: URLSession = .shared
    ) {
        self.config = config
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        let (data, response) = try await requestRaw(endpoint)

        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.from(statusCode: response.statusCode, data: data)
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }

    func requestRaw(_ endpoint: APIEndpoint) async throws -> (Data, HTTPURLResponse) {
        let urlRequest = try endpoint.urlRequest(config: config)

        do {
            let (data, response) = try await session.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.networkUnavailable
            }

            return (data, httpResponse)
        } catch let error as NetworkError {
            throw error
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw NetworkError.networkUnavailable
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
