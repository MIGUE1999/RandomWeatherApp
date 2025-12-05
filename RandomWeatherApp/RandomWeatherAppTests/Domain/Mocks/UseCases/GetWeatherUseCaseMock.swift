import Foundation

@testable import RandomWeatherApp

final class GetWeatherUseCaseMock: GetWeatherUseCaseContract {
    var result: WeatherModel?
    var shouldThrowError = false
    
    func run(location: LocationModel) async throws -> WeatherModel {
        if shouldThrowError {
            throw URLError(.badServerResponse)
        }
        guard let result else {
            fatalError("Missing result for GetWeatherUseCaseMock")
        }
        
        return result
    }
}
