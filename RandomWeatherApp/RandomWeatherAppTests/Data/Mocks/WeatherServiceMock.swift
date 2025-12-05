import Foundation

@testable import RandomWeatherApp

final class WeatherServiceMock: WeatherServiceContract {
    var dataToReturn: Data?
    var errorToThrow: Error?

    func fetchWeather(location: LocationModel) async throws -> Data {
        if let error = errorToThrow { throw error }
        return dataToReturn ?? Data()
    }
}
