//
//  APIService.swift
//  RESTAPi
//
//  Created by tiscomacnb2486 on 18/7/2569 BE.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class APIService: Sendable {
    nonisolated static let shared = APIService()
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: config)
    }
    
    // MARK: - GET
    nonisolated func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Post].self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    nonisolated func fetchPost(id: Int) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            throw APIError.invalidURL
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Post.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - POST
    nonisolated func createPost(request: CreatePostRequest) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(request)
        } catch {
            throw APIError.decodingError(error)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Post.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - PUT
    nonisolated func updatePost(request: UpdatePostRequest) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/\(request.id)") else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(request)
        } catch {
            throw APIError.decodingError(error)
        }
        
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Post.self, from: data)
        } catch {
            throw APIError.decodingError(error)
        }
    }
    
    // MARK: - DELETE
    nonisolated func deletePost(id: Int) async throws {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (_, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(statusCode: httpResponse.statusCode)
        }
    }
}
