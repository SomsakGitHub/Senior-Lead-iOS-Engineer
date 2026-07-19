import Testing
import Foundation
@testable import RequestExecutor

struct MockRequest: Request {
    typealias Response = TestResponse
    let url: String
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
}

struct TestResponse: Decodable, Equatable {
    let id: Int
    let name: String
}

struct MockURLProtocol: URLProtocol {
    static var mockData: Data?
    static var mockError: Error?
    static var mockStatusCode: Int = 200

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: MockURLProtocol.mockStatusCode,
            httpVersion: nil,
            headerFields: nil
        )!
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}

struct RequestExecutorTests {

    let executor: URLSessionRequestExecutor

    init() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        executor = URLSessionRequestExecutor(session: session)
    }

    @Test func executeDecodesResponse() async throws {
        let json = #"{"id":1,"name":"Test"}"#
        MockURLProtocol.mockData = json.data(using: .utf8)
        MockURLProtocol.mockStatusCode = 200
        MockURLProtocol.mockError = nil

        let request = MockRequest(
            url: "https://api.example.com/items",
            method: .get,
            headers: [:],
            body: nil
        )

        let response = try await executor.execute(request)
        #expect(response == TestResponse(id: 1, name: "Test"))
    }

    @Test func executeThrowsOnHTTPError() async throws {
        MockURLProtocol.mockData = Data()
        MockURLProtocol.mockStatusCode = 404
        MockURLProtocol.mockError = nil

        let request = MockRequest(
            url: "https://api.example.com/items",
            method: .get,
            headers: [:],
            body: nil
        )

        await #expect(throws: NetworkError.self) {
            try await executor.execute(request)
        }
    }

    @Test func executeThrowsOnInvalidURL() async throws {
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockError = nil

        let request = MockRequest(
            url: "not a valid url",
            method: .get,
            headers: [:],
            body: nil
        )

        await #expect(throws: NetworkError.self) {
            try await executor.execute(request)
        }
    }

    @Test func executeRawReturnsDataAndResponse() async throws {
        let testData = "hello".data(using: .utf8)!
        MockURLProtocol.mockData = testData
        MockURLProtocol.mockStatusCode = 200
        MockURLProtocol.mockError = nil

        let request = MockRequest(
            url: "https://api.example.com/data",
            method: .get,
            headers: [:],
            body: nil
        )

        let (data, response) = try await executor.executeRaw(request)
        #expect(data == testData)
        #expect(response.statusCode == 200)
    }

    @Test func httpMethodRawValues() {
        #expect(HTTPMethod.get.rawValue == "GET")
        #expect(HTTPMethod.post.rawValue == "POST")
        #expect(HTTPMethod.put.rawValue == "PUT")
        #expect(HTTPMethod.patch.rawValue == "PATCH")
        #expect(HTTPMethod.delete.rawValue == "DELETE")
    }

    @Test func networkErrorDescriptions() {
        let invalidURL = NetworkError.invalidURL
        #expect(invalidURL.errorDescription == "Invalid URL")

        let httpError = NetworkError.httpError(statusCode: 404, data: nil)
        #expect(httpError.errorDescription == "HTTP error 404")

        let timeout = NetworkError.timeout
        #expect(timeout.errorDescription == "Request timed out")
    }
}
