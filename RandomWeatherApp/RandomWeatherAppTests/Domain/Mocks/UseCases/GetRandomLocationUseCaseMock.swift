@testable import RandomWeatherApp

final class GetRandomLocationUseCaseMock: GetRandomLocationUseCaseContract {
    var result: LocationModel?
    func run() -> LocationModel {
        guard let result else {
            fatalError("Missing result for GetWeatherUseCaseMock")
        }
        
        return result
    }
}
