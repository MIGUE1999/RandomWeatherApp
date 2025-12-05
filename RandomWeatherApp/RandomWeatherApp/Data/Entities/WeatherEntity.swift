import Foundation

struct WeatherEntity: Decodable {
    let name: String
    let weather: [WeatherCondition]
    let main: MainInfo

    struct WeatherCondition: Decodable {
        let description: String
        let icon: String?
    }

    struct MainInfo: Decodable {
        let temp: Double
    }

    var currentCondition: WeatherCondition? {
        weather.first
    }
}

