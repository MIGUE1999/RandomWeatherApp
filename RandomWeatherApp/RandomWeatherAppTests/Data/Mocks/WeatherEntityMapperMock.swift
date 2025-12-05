import Foundation

@testable import RandomWeatherApp

final class WeatherEntityMapperMock: WeatherEntityMapperContract {
    var mapCalledWith: WeatherEntity?
    var modelToReturn: WeatherModel?

    func map(from entity: WeatherEntity) -> WeatherModel {
        mapCalledWith = entity
        return modelToReturn ?? WeatherModel(cityName: entity.name, description: "", temperature: "", iconURL: URL(filePath: "mock")!)
    }
}
