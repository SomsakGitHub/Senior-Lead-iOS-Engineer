import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingFailed(Error)
    case serverError(statusCode: Int, data: Data?)
    case networkUnavailable
    case requestFailed(Error)
    case unauthorized
    case forbidden
    case notFound
    case timeout

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingFailed(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .serverError(let statusCode, _):
            return "Server error with status code: \(statusCode)"
        case .networkUnavailable:
            return "Network unavailable"
        case .requestFailed(let error):
            return "Request failed: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Resource not found"
        case .timeout:
            return "Request timed out"
        }
    }

    static func from(statusCode: Int, data: Data? = nil) -> NetworkError {
        switch statusCode {
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 408:
            return .timeout
        default:
            return .serverError(statusCode: statusCode, data: data)
        }
    }
}
