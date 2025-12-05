import Foundation
import os

protocol WeatherRemoteDataSourceContract {
    func getWeather(location: LocationModel) async throws -> WeatherModel
}

final class WeatherRemoteDataSource: WeatherRemoteDataSourceContract {
    private let service: WeatherServiceContract
    private let mapper: WeatherEntityMapperContract
    private let logger = Logger(subsystem: "com.miapp.weather", category: "dataSource")
    
    init(service: WeatherServiceContract = WeatherService(),
         mapper: WeatherEntityMapperContract = WeatherEntityMapper()) {
        self.service = service
        self.mapper = mapper
    }
    
    func getWeather(location: LocationModel) async throws -> WeatherModel {
        let data = try await service.fetchWeather(location: location)
        do {
            let weather = try JSONDecoder().decode(WeatherEntity.self, from: data)
            
            return try mapper.map(from: weather)
        } catch let error as MapperError {
            logger.error("❌ Mapping failure: \(error)")
            throw WeatherError.decodingFailed
        }
        catch {
            logger.error("❌ Decoding failure: \(error)")
            throw WeatherError.decodingFailed
        }
    }
}

enum WeatherError: Error {
    case decodingFailed
}
