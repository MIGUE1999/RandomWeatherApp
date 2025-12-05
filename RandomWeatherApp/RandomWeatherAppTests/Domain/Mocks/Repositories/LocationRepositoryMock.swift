@testable import RandomWeatherApp

final class LocationRepositoryMock: LocationRepositoryContract {
    var result: LocationModel? = nil
    func generateRandomLocation() -> LocationModel {
        guard let result else {
            fatalError("Missing result for MockLocationRepository")
        }
        return result
    }
}
