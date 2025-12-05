import Foundation

@testable import RandomWeatherApp

final class WeatherRepositoryMock: WeatherRepositoryContract {
    var result: WeatherModel?
    var shouldThrowError: Bool = false
    
    func getWeather(location: LocationModel) async throws -> WeatherModel {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        guard let result else {
            fatalError("Missing result for MockWeatherRepository")
        }
        return result
    }
}
