import Foundation

protocol WeatherEntityMapperContract {
    func map(from entity: WeatherEntity) throws -> WeatherModel
}

final class WeatherEntityMapper: WeatherEntityMapperContract {
    func map(from entity: WeatherEntity) throws -> WeatherModel {
        guard let icon = entity.currentCondition?.icon,
              let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") else {
            throw MapperError.invalidUrl
        }

        return WeatherModel(
            cityName: entity.name.isEmpty ? "Unknown city" : entity.name,
            description: entity.currentCondition?.description ?? "",
            temperature: String(entity.main.temp),
            iconURL: iconURL
        )
    }
}

enum MapperError: Error {
    case invalidUrl
}
