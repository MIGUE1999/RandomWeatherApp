protocol GetWeatherUseCaseContract {
    func run(location: LocationModel) async throws -> WeatherModel
}

final class GetWeatherUseCase: GetWeatherUseCaseContract {
    private var weatherRepository: WeatherRepositoryContract
    
    init(weatherRepository: WeatherRepositoryContract = WeatherRepository()) {
        self.weatherRepository = weatherRepository
    }
    
    func run(location: LocationModel) async throws -> WeatherModel {
        try await weatherRepository.getWeather(location: location)
    }
}
