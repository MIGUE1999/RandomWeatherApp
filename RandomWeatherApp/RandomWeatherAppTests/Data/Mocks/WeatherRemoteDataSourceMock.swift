@testable import RandomWeatherApp

final class WeatherRemoteDataSourceMock: WeatherRemoteDataSourceContract {
    var result: WeatherModel?

    func getWeather(location: LocationModel) async throws -> WeatherModel {
        guard let result else {
            fatalError("Missing result in RemoteWeatherDataSourceMock")
        }

        return result
    }
}
