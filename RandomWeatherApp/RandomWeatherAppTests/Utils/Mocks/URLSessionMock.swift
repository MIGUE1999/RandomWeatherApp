import Foundation

@testable import RandomWeatherApp

final class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let error = error { throw error }
        return (data ?? Data(), response ?? URLResponse())
    }
}
