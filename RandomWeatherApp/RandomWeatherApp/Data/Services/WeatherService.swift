import Foundation
import os

protocol WeatherServiceContract {
    func fetchWeather(location: LocationModel) async throws -> Data
}

final class WeatherService: WeatherServiceContract {
    private let session: URLSessionProtocol
    private let logger = Logger(subsystem: "com.miapp.weather", category: "network")
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchWeather(location: LocationModel) async throws -> Data {
        let endpoint = WeatherEndpoint(lat: location.latitude, lon: location.longitude)
        let request = URLRequest(url: endpoint.url)
        
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            logger.error("❌ Bad Response")
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            logger.error("❌ Invalid StatusCode: \(httpResponse.statusCode)")
            throw URLError(.badServerResponse)
        }
        return data
    }
    
    private struct WeatherEndpoint: ApiEndpointContract {
        let baseURL = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
        let lat: Double
        let lon: Double
        let units: String = "metric"
        let appid = APIKeyProvider.apiKey

        var queryParameters: [String: String] {
            return [
                "lat": "\(lat)",
                "lon": "\(lon)",
                "units": "\(units)",
                "appid": "\(appid)"
            ]
        }
        
        var url: URL {
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            return components.url!
        }
    }
}
