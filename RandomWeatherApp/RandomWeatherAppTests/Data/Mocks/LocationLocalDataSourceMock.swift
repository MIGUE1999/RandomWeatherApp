@testable import RandomWeatherApp

final class LocationLocalDataSourceMock: LocationLocalDataSourceContract {
    var result: LocationModel?

    func generateRandomLocation() -> LocationModel {
        guard let result else {
            fatalError("Missing mocked result in LocationLocalDataSourceMock")
        }
        return result
    }
}
